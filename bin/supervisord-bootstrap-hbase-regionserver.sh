#!/bin/bash

./wait-for-it.sh hbase-master:60010  -t 300
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "      hbase-master not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

./start-hbase-regionserver.sh
