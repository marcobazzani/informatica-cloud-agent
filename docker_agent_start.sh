#!/bin/sh

set -e
cd /root/infaagent
./agent_start.sh  &

/root/infaagent/main/agentcore/consoleAgentManager.sh configure $1 $2 

fg
