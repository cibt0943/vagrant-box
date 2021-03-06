#!/bin/bash -eux

echo '==> Configuring settings for vagrant'

SSH_USER=${SSH_USER:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}


# Vagrant用の公開鍵を登録
if [ "$INSTALL_VAGRANT_KEY" = "true" ] || [ "$INSTALL_VAGRANT_KEY" = "1" ]; then
  echo '==> Installing Vagrant SSH key'
  mkdir -pm 700 ${SSH_USER_HOME}/.ssh
  curl -o ${SSH_USER_HOME}/.ssh/authorized_keys -kL ${VAGRANT_INSECURE_KEY_URL}
  chmod 0600 ${SSH_USER_HOME}/.ssh/authorized_keys
  chown -R ${SSH_USER}:${SSH_USER} ${SSH_USER_HOME}/.ssh
fi

echo '==> Customizing message of the day'
echo 'Welcome to your Packer-built virtual machine.' > /etc/motd