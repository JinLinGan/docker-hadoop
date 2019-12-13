#!/bin/bash

echo -e "\n---------------------------------------"

echo -e	"Starting hbase-regionserver..."
supervisorctl start hbase-regionserver
