#!/bin/bash

supervisorctl start yarn-nodemanager
./wait-for-it.sh localhost:8042 -t 60
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "YARN Node Manager not ready! Exiting..."
    echo -e "--------------------------------------------"
    exit $rc
fi
