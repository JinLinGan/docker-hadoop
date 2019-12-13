#!/bin/bash

./wait-for-it.sh hbase-master:60010 -t 600
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "       YARN Application History not ready! ..."
    echo -e "--------------------------------------------"
    exit $rc
fi
HBASE_EXAMPLE_CLASSPATH=`./bin/hbase classpath`

count=1
echo -e "开始循环运行测试案例"
while :
do
echo -e "开始第 $count 次任务"
java -cp /usr/lib/hbase/hbase-examples-1.2.0-cdh5.16.2.jar:$HBASE_EXAMPLE_CLASSPATH  org.apache.hadoop.hbase.thrift.DemoClient hbase-master 9090
echo -e "第 $count 次任务结束"
count=$(( count+1 ))
done
