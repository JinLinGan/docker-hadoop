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


echo -e "创建测试文件夹 /test"
hadoop fs -mkdir -p /test
echo -e "设置 /test allowSnapshot"
hdfs dfsadmin -allowSnapshot /test
echo -e "创建第一个快照"
hadoop fs -createSnapshot /test/ s-first.snap
count=1
echo -e "开始循环运行测试案例"
while :
do
echo -e "开始第 $count 次任务"
echo -e "开始提交测试文件到 HDFS /test/test.file"
hadoop fs -copyFromLocal /tmp/test.file /test/
echo -e "提交结束 HDFS /test/test.file"

hadoop fs -ls /test
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar wordcount   /test/test.file /test/out
hadoop fs -cat /test/out/part-r-00000
hadoop fs -rm -r -f /test/test.file
hadoop fs -createSnapshot /test/ s-$count.snap
hadoop fs -deleteSnapshot /test/ s-$(( count-1 )).snap
hadoop fs -rm -r -f /test/out
echo -e "第 $count 次任务结束"
count=$(( count+1 ))
done
