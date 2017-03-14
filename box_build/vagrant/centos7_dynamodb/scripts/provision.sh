#!/bin/bash

yum install -y wget jre

mkdir -p /opt/dynamodb_local
chmod 777 /opt/dynamodb_local
cd /opt/dynamodb_local

wget http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest.tar.gz
tar xzvf dynamodb_local_latest.tar.gz

# デーモン化
cp /vagrant/tpl/dynamodb.service /usr/lib/systemd/system/dynamodb.service
echo '#!/bin/bash' >> run.sh
echo 'java -Djava.library.path=/opt/dynamodb_local/DynamoDBLocal_lib -jar /opt/dynamodb_local/DynamoDBLocal.jar -sharedDb' >> run.sh
chmod 755 run.sh
systemctl start dynamodb.service
systemctl enable dynamodb.service

echo '==> end setup.sh'
