FROM alpine:3.10

ARG ansible_version

RUN apk add --no-cache \
    openssh-client sudo \
    python3 py3-pip \
    gcc libffi-dev make musl-dev openssl-dev python3-dev

RUN addgroup --system ansible && \
    adduser --system --disabled-password --shell /bin/bash --ingroup ansible ansible && \
    mkdir -p /home/ansible/.ssh && \
    chown -R ansible: /home/ansible && \
    sed -i -E 's/%sudo\s+ALL=\(ALL:ALL\) ALL/%sudo ALL=\(ALL:ALL\) NOPASSWD:ALL/g' /etc/sudoers && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN pip3 --no-cache-dir install \
    ansible==${ansible_version} \
    ansible-lint

RUN apk add bash supervisor

COPY supervisord.conf /etc/supervisord.conf

RUN rm -f /run/nologin

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]


COPY id_rsa* /home/ansible/.ssh/

RUN chmod 600 /home/ansible/.ssh/id_rsa* && \
    chown ansible: /home/ansible/.ssh/id_rsa*

RUN mkdir /var/log/supervisord /var/run/supervisord && \
    chown ansible: /var/log/supervisord /var/run/supervisord

USER ansible

LABEL playwithansible.ansible.version=${ansible_version}
LABEL org.opencontainers.image.source https://github.com/playwithansible/playwithansible