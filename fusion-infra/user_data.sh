#!/bin/bash
sudo useradd -m devops
echo "devops:Devops@321" | sudo chpasswd
sudo usermod -aG sudo devops
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
sudo systemctl restart sshd