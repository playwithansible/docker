ARG version
FROM ubuntu:${version}

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y python3 openssh-server sudo supervisor

RUN adduser --system --disabled-password --shell /bin/bash --group ansible && \
    mkdir -p /home/ansible/.ssh && \
    usermod -aG sudo ansible && \
    sed -i -E 's/%sudo\s+ALL=\(ALL:ALL\) ALL/%sudo ALL=\(ALL:ALL\) NOPASSWD:ALL/g' /etc/sudoers
    
COPY id_rsa.pub /home/ansible/.ssh/authorized_keys
RUN chown -R ansible:ansible /home/ansible

RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd
COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

LABEL playwithansible.distribution.name=ubuntu \
      playwithansible.distribution.version=${version}
LABEL org.opencontainers.image.source https://github.com/playwithansible/playwithansible