FROM alpine:3.10

ARG ansible_version

RUN apk add --no-cache \
    bash \
    openssh-client sudo \
    python3 py3-pip py3-psutil \
    supervisor \
    gcc libffi-dev libxslt-dev make musl-dev openssl-dev python3-dev

RUN addgroup --system ansible && \
    adduser --system --disabled-password --shell /bin/bash --ingroup ansible ansible && \
    mkdir -p /home/ansible/.ssh && \
    chown -R ansible: /home/ansible && \
    addgroup ansible wheel && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/wheel && \
    #sed -i -E 's/%wheel\s+ALL=\(ALL:ALL\) ALL/%wheel ALL=\(ALL:ALL\) NOPASSWD:ALL/g' /etc/sudoers && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN pip3 install --upgrade pip && \
    pip3 --no-cache-dir install \
    ansible==${ansible_version} \
    ansible-lint \
    ansible-runner

RUN mkdir /var/log/supervisord /var/run/supervisord && \
    chown ansible: /var/log/supervisord /var/run/supervisord
RUN mkdir -p /ansible/inventories/groupvars /ansible/inventories/hostvars /ansible/runner && \
    chown -R ansible: /ansible/inventories /ansible/runner
RUN rm -f /run/nologin

COPY supervisord.conf /etc/supervisord.conf

COPY id_rsa* /home/ansible/.ssh/
RUN chmod 600 /home/ansible/.ssh/id_rsa* && \
    chown ansible: /home/ansible/.ssh/id_rsa*

ADD requirements.txt /tmp/
RUN pip3 --no-cache-dir install -r /tmp/requirements.txt

ENTRYPOINT [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]

USER ansible

# Docker Image Labels
LABEL playwithansible.ansible.version=${ansible_version}
LABEL org.opencontainers.image.source https://github.com/playwithansible/playwithansible