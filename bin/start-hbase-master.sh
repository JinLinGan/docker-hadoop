#!/bin/bash

echo -e "\n---------------------------------------"

sudo -E -u hdfs hdfs dfs -mkdir /hbase
sudo -E -u hdfs hdfs dfs -chown hbase /hbase

echo -e	"Starting hbase-master..."
supervisorctl start hbase-master
supervisorctl start hbase-thrift