FROM ayen/ubuntu-base
MAINTAINER Ayen Ling <ling@ayen.cc>
ENV AYEN_VERSION 20160301-0904
RUN apt-get -qq update && apt-get -qqy install openssh-server
RUN mkdir -p /var/run/sshd
RUN echo "root:ayen.cc" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
#CLEAN
RUN apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 22
CMD /usr/sbin/sshd -D
