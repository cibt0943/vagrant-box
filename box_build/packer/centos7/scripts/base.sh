#!/bin/bash

echo '==> Configuring sshd_config options'

echo '==> Turning off sshd DNS lookup to prevent timeout delay'
echo "UseDNS no" >> /etc/ssh/sshd_config

echo '==> Disablng GSSAPI authentication to prevent timeout delay'
echo "GSSAPIAuthentication no" >> /etc/ssh/sshd_config


echo "==> Applying updates"
yum -y update

# reboot
echo "Rebooting the machine..."
reboot
sleep 120