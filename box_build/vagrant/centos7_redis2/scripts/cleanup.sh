#!/bin/bash

# 仮想マシンのMACアドレスの固定化を解除(box化して他者へ渡すため)
if [ -e /etc/udev/rules.d/70-persistent-ipoib.rules ]; then
  rm /etc/udev/rules.d/70-persistent-ipoib.rules
fi

# yumのキャッシュクリア
yum clean all

# tmpディレクトリ内を全て削除
rm -rf /tmp/*

# 履歴削除
if [ -e ~/.bash_history ]; then
  rm ~/.bash_history
fi

# ディスクサイズを小さくするために仮想ハードディスクの未使用領域をゼロ埋め
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY