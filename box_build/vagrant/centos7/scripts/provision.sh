#!/bin/bash

# timezone設定
timedatectl set-timezone UTC

# firewall停止
systemctl stop firewalld
systemctl disable firewalld

# SELinux停止
setenforce 0
sed -i -e 's/SELINUX *= *enforcing/SELINUX=disabled/' /etc/selinux/config

yum -y update

# epelリポジトリ追加
yum install -y epel-release
# epelリポジトリは明示的に利用するように無効化しておく
sed -i -e 's/enabled *= *1/enabled=0/g' /etc/yum.repos.d/epel.repo
# ミラーサイトは使わない
sed -i -e 's/^#baseurl/baseurl/g' /etc/yum.repos.d/epel.repo
sed -i -e 's/^mirrorlist/#mirrorlist/g' /etc/yum.repos.d/epel.repo

# 古いカーネル削除
yum -y install yum-utils
package-cleanup -y --oldkernels


# 確認用
echo '==> CentOS version'
cat /etc/redhat-release
echo '==> timezone'
timedatectl