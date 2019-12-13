#!/bin/bash

echo -e "\n---------------------------------------"


echo -e	"Starting hbase-master..."
supervisorctl start hbase-master
supervisorctl start hbase-thrift