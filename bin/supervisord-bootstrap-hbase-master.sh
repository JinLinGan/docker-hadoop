#!/bin/bash

rm -f /etc/security/limits.d/hbase.conf

./wait-for-it.sh hadoop-master:8020  -t 300
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "      Zookeeper not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

./start-hbase-master.sh
./wait-for-it.sh hbase-master:60000  -t 300
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "      hbase-master not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

./start-hbase-regionserver.sh
