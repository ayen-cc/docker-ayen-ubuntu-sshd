FROM ubuntu:14.04
MAINTAINER Ayen Ling <ling@ayen.cc>
ENV UPDATE_TIME 20160228-2328
RUN apt-get -qq update && apt-get -qqy install openssh-server
RUN mkdir -p /var/run/sshd
RUN echo "root:ayen.cc" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
EXPOSE 22
ENTRYPOINT /usr/sbin/sshd -D
