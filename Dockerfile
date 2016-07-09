FROM centos:latest
MAINTAINER Marco Bazzani <mbazzani@doxee.com>

WORKDIR "/root"
#COPY agent64_install.bin /root
RUN yum -y install wget nc
#RUN wget https://icinq1.informaticacloud.com/saas/download/linux64/installer/agent64_install.bin 
RUN wget http://172.16.1.108/saas/download/linux64/installer/agent64_install.bin
RUN chmod +x /root/agent64_install.bin
RUN echo -e "\n\n\n\n" | /root/agent64_install.bin || echo OK
WORKDIR "/root/infaagent"
COPY setup.sh .
COPY client.sh .
RUN chmod +x setup.sh
RUN chmod +x client.sh
RUN ./setup.sh
CMD /root/infaagent/agent_start.sh
