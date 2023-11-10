#!/usr/bin/env bash


echo "etcd will be installed:"
sleep 3

ETCD_VERSION='3.5.10'
wget https://github.com/etcd-io/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
tar -xvf etcd-v${ETCD_VERSION}-linux-amd64.tar.gz && \
  cd etcd-v${ETCD_VERSION}-linux-amd64 && \
  sudo cp -a etcd etcdctl /usr/bin/
nohup etcd >/tmp/etcd.log 2>&1 &

echo "====================================================================================="

echo "If OpenResty is not installed, you can run the command below to install both OpenResty and APISIX repositories:"
sleep 3
sudo yum install -y https://repos.apiseven.com/packages/centos/apache-apisix-repo-1.0-1.noarch.rpm

echo "If OpenResty is installed, the command below will install the APISIX repositories:"
sleep 3
sudo yum-config-manager --add-repo https://repos.apiseven.com/packages/centos/apache-apisix.repo

echo "installing APISIX"
sudo yum install apisix

echo "initializing the configuration file etcd by running:"
apisix init

echo "To start APISIX server, run:"
apisix start
