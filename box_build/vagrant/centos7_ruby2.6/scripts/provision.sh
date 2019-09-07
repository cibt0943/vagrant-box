#!/bin/bash

# gitインストール
sudo yum -y install git

# rbenvのインストール
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# PATH設定
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

# ruby-buildのインストール
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# rubyのビルドに必要なライブラリのインストール
sudo yum -y install bzip2 gcc openssl-devel readline-devel zlib-devel

# rubyインストール
rbenv install -v $1

# 利用するバージョンの設定
rbenv global $1
rbenv rehash

# bundlerのインストール
# rbenv exec gem install bundler -N


# 確認用
echo '==> Ruby version'
ruby -v
