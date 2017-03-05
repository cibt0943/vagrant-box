#!/bin/bash

# redisのインストール
yum y --enablerepo=epel install redis

# redisへのアクセス可能IPを無制限に設定
cp /etc/redis.conf /etc/redis.conf.backup
sed -i -e 's/bind *127.0.0.1/bind 0.0.0.0/' /etc/redis.conf

# redis起動
systemctl start redis.service
systemctl enable redis.service

# firewallにてredisが使う6379ポートへのアクセスを許可
#firewall-cmd --permanent --add-port=6379/tcp
#firewall-cmd --reload


# 確認用
echo '==> Redis version'
redis-server --version