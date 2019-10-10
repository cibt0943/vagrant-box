#!/bin/bash

# gitインストール
yum -y install git

# rubyのビルドに必要なライブラリのインストール
yum -y install bzip2 gcc openssl-devel readline-devel zlib-devel

# rbenvのインストール
git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv

# ruby-buildのインストール
git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build

# PATH設定
echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh
echo 'export PATH=$RBENV_ROOT/bin:$PATH' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh

# sudoのPATHにrbenvの実行ファイルパスを追加
cat <<EOF > /etc/sudoers.d/rbenv
Defaults secure_path=/sbin:/bin:/usr/sbin:/usr/bin:$RBENV_ROOT/bin:$RBENV_ROOT/shims
EOF

# rubyインストール
rbenv install -v $1

# 利用するバージョンの設定
rbenv global $1


# 確認用
echo '==> Ruby version'
ruby -v
