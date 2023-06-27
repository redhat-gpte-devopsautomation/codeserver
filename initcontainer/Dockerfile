# Use Red Hat Universal Base Image 9 - Minimal
FROM registry.access.redhat.com/ubi9/ubi-minimal:latest

# Software versions
ENV CODE_SERVER_VERSION="4.14.1"

LABEL name="Code Server - Developer IDE - Init Container" \
      vendor="Code Server" \
      io.k8s.display-name="Code Server - Developer IDE - Init Container" \
      build-date="2023-06-27" \
      version=$CODE_SERVER_VERSION \
      release="1" \
      maintainer="Wolfgang Kulhanek <wkulhanek@redhat.com>"

RUN microdnf -y update && \
    microdnf -y install python-devel sudo git && \
    rpm -i https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server-${CODE_SERVER_VERSION}-amd64.rpm && \
    rm -rf /var/cache/dnf /root/.cache

RUN pip3 --no-cache-dir install ansible

COPY setup-code-server.sh /usr/bin/setup-code-server.sh

RUN adduser codeserver --home-dir=/home/codeserver && \
    chmod 770 /home/codeserver && \
    chgrp 0 /home/codeserver && \
    chmod -R g=u /home/codeserver /etc/passwd && \
    chmod +x /usr/bin/setup-code-server.sh && \
    mkdir /var/ansible

COPY ./ansible/* /var/ansible

RUN chown -R codeserver:root /var/ansible

USER codeserver
WORKDIR /home/codeserver
VOLUME /home/codeserver

ENTRYPOINT ["/usr/bin/setup-code-server.sh"]
CMD ["ansible-playbook", "/var/ansible/setup-code-server.yml"]
