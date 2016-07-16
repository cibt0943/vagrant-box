#!/bin/bash

# railsのインストールに必要なライブラリをインストール
sudo yum -y install expect

# プロジェクトディレクトリ作成
rm -r ~/$1
mkdir ~/$1
cd ~/$1

# Gemfile生成
rm Gemfile
bundle init
echo 'gem "rails", ">= 5.0.0", "< 5.1"' >> Gemfile

# bundleにてrailsインストール
bundle install --path=vendor/bundle

# railsコマンドにてrailsフレームワークのソース作成(DBはmysql)
# (途中でgemfileの上書き確認があるのでexpectにて対話式に対応)
if [ $2 = "1" ]; then
  # DBあり
  expect -c "
  set timeout 10
  spawn bundle exec rails new . -d mysql --skip-test-unit --skip-bundle
  expect {Overwrite /home/vagrant/$1/Gemfile? (enter \"h\" for help) \[Ynaqdh]}
  send \"y\n\"
  sleep 3
  interact
  "
else
  # DB無し
  expect -c "
  set timeout 10
  spawn bundle exec rails new . -O --skip-test-unit --skip-bundle
  expect {Overwrite /home/vagrant/$1/Gemfile? (enter \"h\" for help) \[Ynaqdh]}
  send \"y\n\"
  sleep 3
  interact
  "
fi

# bundleにてもろもろインストール
# bundle install

# 共有フォルダ内に移動
chmod -R 777 /vagrant/src/$1
rm -r /vagrant/src/$1
mv ~/$1 /vagrant/src

echo "==>finished"