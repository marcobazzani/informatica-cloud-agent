FROM centos:latest
MAINTAINER Marco Bazzani <mbazzani@doxee.com>

WORKDIR "/root"
RUN yum -y install wget nc
RUN wget https://icinq1.informaticacloud.com/saas/download/linux64/installer/agent64_install.bin 
#RUN wget http://172.16.1.108/saas/download/linux64/installer/agent64_install.bin
RUN chmod +x /root/agent64_install.bin
RUN echo -e "\n\n\n\n" | /root/agent64_install.bin || echo OK
WORKDIR "/root/infaagent"
#COPY setup.sh .
#ADD setup.sh .
#ADD client.sh .
#Workaround for travis
RUN wget https://raw.githubusercontent.com/visik7/informatica-cloud-agent/visik7-travis/client.sh
RUN wget https://raw.githubusercontent.com/visik7/informatica-cloud-agent/visik7-travis/setup.sh
RUN chmod +x setup.sh
RUN chmod +x client.sh
RUN ./setup.sh
CMD /root/infaagent/agent_start.sh
