#!/bin/bash

# mysqlのrpm登録
yum -y install http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm

# mysqlのrpmは明示的に利用
sed -i -e 's/enabled *= *1/enabled=0/g' /etc/yum.repos.d/mysql-community.repo

# mysql5.6 server community版をインストール
yum -y --enablerepo=mysql56-community install mysql-community-server

# mysql起動
systemctl start mysqld.service
systemctl enable mysqld.service

# firewallに対しmysqlへのアクセスを許可
#firewall-cmd --permanent --add-service=mysql
#firewall-cmd --reload


# 確認用
echo '==> MySQL version'
mysql --version