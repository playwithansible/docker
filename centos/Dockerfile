ARG version
FROM centos:${version}

RUN yum install -y epel-release && \
    yum update -y && \
    yum upgrade -y && \
    yum install -y python3 openssh-server sudo supervisor

RUN groupadd --system ansible && \
    groupadd --system sudo && \
    adduser --system --shell /bin/bash -g ansible ansible && \
    mkdir -p /home/ansible/.ssh && \
    usermod -aG sudo ansible && \
    echo "%sudo ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY id_rsa.pub /home/ansible/.ssh/authorized_keys
RUN chown -R ansible:ansible /home/ansible

RUN /usr/bin/ssh-keygen -A

RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd
COPY supervisord.conf /etc/supervisord.conf

RUN mkdir /var/log/supervisord /var/run/supervisord && \
    chown ansible: /var/log/supervisord /var/run/supervisord

RUN rm -f /run/nologin

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

LABEL playwithansible.distribution.name=centos \
      playwithansible.distribution.version=${version}
LABEL org.opencontainers.image.source https://github.com/playwithansible/playwithansible