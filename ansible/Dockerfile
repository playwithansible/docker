FROM alpine:3.10

ARG ansible_version

RUN apk update && \
    apk add python py3-pip sudo

RUN apk add gcc

RUN apk add libffi-dev musl-dev openssl-dev python3-dev

RUN pip3 install ansible==${ansible_version}

RUN addgroup --system ansible && \
    adduser --system --disabled-password --shell /bin/bash --ingroup ansible ansible && \
    mkdir -p /home/ansible/.ssh && \
    sed -i -E 's/%sudo\s+ALL=\(ALL:ALL\) ALL/%sudo ALL=\(ALL:ALL\) NOPASSWD:ALL/g' /etc/sudoers

RUN apk add openssh-client

#COPY id_rsa* /home/ansible/.ssh/

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN chown -R ansible: /home/ansible

USER ansible

LABEL playwithansible.ansible.version=${ansible_version}