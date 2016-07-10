#!/bin/sh

set -e
cd /root/infaagent
./agent_start.sh > build.log &

sleep 5 

HOST=52.28.253.196
PORT=80
#echo USERNAME_PASSWORD > /dev/tcp/$HOST/$PORT
#USERNAME_PASSWORD=$(3>&1  nc -c ./client.sh $HOST $PORT )
USERNAM_PASSWORD="osajhfgl@sharklasers.com changePassword"

USERNAME=$(echo $USERNAME_PASSWORD | awk '{print $1}')
PASSWORD=$(echo $USERNAME_PASSWORD | awk '{print $2}')

/root/infaagent/main/agentcore/consoleAgentManager.sh configure $USERNAME $PASSWORD

tail -F build.log | while read line
do 
    if [[ "${line}" == *"Tomcat is listening at port:"* ]] ; then
        kill $(ps uax |grep "main/agentcore" |grep java |grep -v grep | awk '{print $2}') 
        kill $(ps uax |grep tail |grep -v grep | awk '{print $2}') 
    fi
    echo $line 
done 

