ARG version

FROM fedora:${version}

RUN yum update -y && \
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

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

LABEL playwithansible.distribution.name=fedora \
      playwithansible.distribution.version=${version}
LABEL org.opencontainers.image.source=https://github.com/playwithansible/docker