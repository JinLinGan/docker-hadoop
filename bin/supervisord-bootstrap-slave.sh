#!/bin/bash

./wait-for-it.sh zookeeper:2181 -t 120
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "      Zookeeper not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi

./start-hdfs-datanode.sh
./start-yarn-node.sh

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hadoop Web UIs:"
echo -e ""
echo -e "Hadoop - DataNode:                     http://localhost:50075"
echo -e "Hadoop - YARN Node Manager:            http://localhost:8042"
echo -e "--------------------------------------------------------------------------------\n\n"
