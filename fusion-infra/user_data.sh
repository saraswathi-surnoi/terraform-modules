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

