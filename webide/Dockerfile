ARG theia_version

FROM theiaide/theia-python:${theia_version}

ENV LANG en_US.utf8
ENV LC_ALL en_US.utf8

ARG ansible_version
ARG theia_version
# ARG vault_version

RUN apt-get update -y && \
    apt-get install -y python3 python3-pip sudo

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install ansible==${ansible_version}

RUN adduser --system --disabled-password --shell /bin/bash --group ansible && \
    mkdir -p /home/ansible/.ssh && \
    usermod -aG sudo ansible && \
    sed -i -E 's/%sudo\s+ALL=\(ALL:ALL\) ALL/%sudo ALL=\(ALL:ALL\) NOPASSWD:ALL/g' /etc/sudoers

COPY id_rsa* /home/ansible/.ssh/

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

ADD ansible /ansible

RUN chown -R ansible: /home/ansible /ansible

RUN git clone https://github.com/VSChina/vscode-ansible.git /home/theia/plugins/vscode-ansible && \
    git clone https://github.com/evilz/vscode-reveal.git /home/theia/plugins/vscode-reveal

# RUN wget https://releases.hashicorp.com/vault/1.4.2/vault_1.4.2_linux_amd64.zip -q -O /tmp/vault_1.4.2_linux_amd64.zip && \
#     unzip /tmp/vault_1.4.2_linux_amd64.zip -d /usr/local/bin/

USER ansible

LABEL playwithansible.ansible.version=${ansible_version} \
      playwithansible.theia.version=${theia_version} \
      playwithansible.vault.version=${theia_version}