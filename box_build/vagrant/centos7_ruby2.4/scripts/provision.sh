#!/bin/bash

# gitインストール
yum -y install git

# rbenvのインストール
git clone git://github.com/sstephenson/rbenv.git /usr/local/rbenv

# ruby-buildのインストール
git clone git://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build

# PATH設定
echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
echo 'export PATH=$RBENV_ROOT/bin:$PATH' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh

# rubyのビルドに必要なライブラリのインストール
yum -y install gcc bzip2 openssl-devel readline-devel zlib-devel

# rubyインストール
rbenv install -v $1

# 利用するバージョンの設定
rbenv global $1

# bundlerのインストール
rbenv exec gem install bundler --no-ri --no-rdoc


# 確認用
echo '==> Ruby version'
ruby -v