#!/bin/bash
sudo apt-get update -y
sudo apt-get install vsftpd
useradd -m -G sudo -s /usr/bin/bash ${var.username}
echo "${var.username}:${var.password}" > users.txt
chpasswd < users.txt
rm users.txt

