#!/bin/sh

set -e
cd /root/infaagent
./agent_start.sh > build.log &

sleep 5 

HOST=52.28.253.196
PORT=80
echo USERNAME > /dev/tcp/$HOST/$PORT
USERNAME=$(3>&1  nc -c ./client.sh $HOST $PORT )
echo PASSWORD > /dev/tcp/$HOST/$PORT
PASSWORD=$(3>&1  nc -c ./client.sh $HOST $PORT )

/root/infaagent/main/agentcore/consoleAgentManager.sh configure $USERNAME $PASSWORD

tail -F build.log | while read line
do 
    if [[ "${line}" == *"Tomcat is listening at port:"* ]] ; then
        kill $(ps uax |grep "main/agentcore" |grep java |grep -v grep | awk '{print $2}') 
        kill $(ps uax |grep tail |grep -v grep | awk '{print $2}') 
    fi
    echo $line 
done 

