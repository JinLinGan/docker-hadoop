#!/bin/bash

./wait-for-it.sh hadoop-master:8188 -t 600
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n--------------------------------------------"
    echo -e "       YARN Application History not ready! ..."
    echo -e "--------------------------------------------"
    exit $rc
fi

echo -e "开始生成测试文件，约 500MB"
for x in {1..5000}
do 
    cat /tmp/in.txt >> /tmp/test.file
done
echo -e "生成结束"


echo -e "开始循环运行测试案例"
while :
do
echo -e "开始提交测试文件到 HDFS /tmp/test.file"
hadoop fs -copyFromLocal /tmp/test.file /tmp/
echo -e "提交结束 HDFS /tmp/test.file"

hadoop fs -ls /tmp
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar wordcount   /tmp/test.file /tmp/out
hadoop fs -cat /tmp/out/part-r-00000
hadoop fs -rm -r -f /tmp/out
hadoop fs -rm -r -f /tmp/test.file
done
