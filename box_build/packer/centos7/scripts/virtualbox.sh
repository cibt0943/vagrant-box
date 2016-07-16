#!/bin/bash -eux

SSH_USER=${SSH_USER:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}


# Virtualboxの共有フォルダを利用する為、Guest Additionsをインストール
if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
  echo "==> Applying install"
  yum -y install bzip2 gcc kernel-devel perl

  echo "==> Installing VirtualBox guest additions"
  VBOX_VERSION=$(cat $SSH_USER_HOME/.vbox_version)
  mount -o loop $SSH_USER_HOME/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
  sh /mnt/VBoxLinuxAdditions.run --nox11
  umount /mnt

  # 不要になったインストーラを削除
  rm -rf $SSH_USER_HOME/VBoxGuestAdditions_$VBOX_VERSION.iso
  rm -f $SSH_USER_HOME/.vbox_version
fi