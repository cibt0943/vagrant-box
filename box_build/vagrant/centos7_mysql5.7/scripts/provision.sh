#!/bin/bash

# mariadbの削除
yum remove mariadb-libs

# mysqlのrpmインストール
yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm

# mysql5.7 server community版をインストール
yum -y install mysql-community-server

# mysql起動
systemctl start mysqld.service
systemctl enable mysqld.service

# firewallに対しmysqlへのアクセスを許可
#firewall-cmd --permanent --add-service=mysql
#firewall-cmd --reload


# 確認用
echo '==> MySQL version'
mysql --version
