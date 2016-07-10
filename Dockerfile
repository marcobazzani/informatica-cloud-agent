FROM centos:latest
MAINTAINER Marco Bazzani <mbazzani@doxee.com>

WORKDIR "/root"
RUN yum -y install wget nc
RUN wget https://app2.informaticacloud.com/saas/download/linux64/installer/agent64_install.bin
RUN chmod +x /root/agent64_install.bin
RUN echo -e "\n\n\n\n" | /root/agent64_install.bin || echo OK
WORKDIR "/root/infaagent"
#COPY setup.sh .
#COPY client.sh .
#Workaround for travis
RUN wget https://raw.githubusercontent.com/visik7/informatica-cloud-agent/visik7-travis/client.sh
RUN wget https://raw.githubusercontent.com/visik7/informatica-cloud-agent/visik7-travis/setup.sh
RUN wget https://raw.githubusercontent.com/visik7/informatica-cloud-agent/visik7-travis/docker_agent_start.sh
RUN chmod +x setup.sh
RUN chmod +x client.sh
RUN chmod +x docker_agent_start.sh
RUN ./setup.sh
RUN echo "InfaAgent.MasterUrl=https://app.informaticaondemand.com/ma" > /root/infaagent/main/infaagent.ini
ENTRYPOINT [ '/root/infaagent/docker_agent_start.sh' ]
CMD ['USERNAME', 'PASSWORD']
