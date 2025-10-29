#cloud-config
users:
  - name: devops
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    groups: sudo
    home: /home/devops
    shell: /bin/bash
    lock_passwd: false
    plain_text_passwd: "Devops@321"

ssh_pwauth: true
disable_root: true
runcmd:
  - sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
  - sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
  - sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
  - sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
  - systemctl restart sshd

  
#!/bin/bash

# ------------------ COLORS ------------------
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

# ------------------ VARIABLES ------------------
TIMESTAMP=$(date +%F-%H-%M-%S)
LOG_FILE="/tmp/backend_installation_log_$TIMESTAMP.log"
ID=$(id -u)

echo "Script started at $TIMESTAMP" &>> $LOG_FILE

# ------------------ VALIDATION FUNCTION ------------------
VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2 process $R FAILED $N"
        exit 1
    else
        echo -e "$2 process $G SUCCESS $N"
    fi
}

# ------------------ ROOT ACCESS CHECK ------------------
if [ $ID -ne 0 ]; then
    echo -e "$R Error: Please run as root $N"
    exit 1
fi

echo "--------- Backend Configuration in progress, please wait... --------------- "

# ------------------ GIT INSTALLATION ------------------
yum list installed git &>> $LOG_FILE
if [ $? -ne 0 ]; then
    yum install git -y &>> $LOG_FILE
    VALIDATE $? "Git Installed"
else
    echo -e "Git already Installed $Y SKIPPING $N"
fi

echo "Git version: $(git --version)"

# ------------------ JAVA 21 INSTALLATION ------------------
yum list installed java-21-amazon-corretto-devel &>> $LOG_FILE
if [ $? -ne 0 ]; then
    yum install java-21-amazon-corretto-devel -y &>> $LOG_FILE
    VALIDATE $? "Java 21 Installed"
else
    echo -e "Java 21 already Installed $Y SKIPPING $N"
fi

# ------------------ MAVEN INSTALLATION ------------------
rm -rf /opt/ap* /opt/maven
cd /opt

wget https://archive.apache.org/dist/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz &>> $LOG_FILE
tar xvf apache-maven-3.9.8-bin.tar.gz &>> $LOG_FILE
mv apache-maven-3.9.8 maven
rm -f apache-maven-3.9.8-bin.tar.gz

# Add Maven to PATH
if [[ ! "$PATH" =~ "/opt/maven/bin" ]]; then
    echo "export PATH=\$PATH:/opt/maven/bin" >> /etc/profile
    source /etc/profile
fi

cd -
mvn --version &>> $LOG_FILE
VALIDATE $? "Maven Installed"

# ------------------ DOCKER INSTALLATION ------------------
yum list installed docker &>> $LOG_FILE
if [ $? -ne 0 ]; then
    yum install docker -y &>> $LOG_FILE
    systemctl enable docker &>> $LOG_FILE
    systemctl start docker &>> $LOG_FILE
    VALIDATE $? "Docker Installed and Started"
else
    echo -e "Docker already Installed $Y SKIPPING $N"
fi

echo -e "$G Backend dependencies installation completed successfully! $N"
echo "Check logs at: $LOG_FILE"
