# Use Red Hat Universal Base Image 8
FROM registry.access.redhat.com/ubi8/ubi:latest

# Software versions
ENV CODE_SERVER_VERSION="4.5.0"
ENV MAVEN_VERSION="3.8.6"
ENV OCP_VERSION="4.10"

# Directories
ENV CODE_SERVER_HOME=/home/codeserver

LABEL name="Code Server - Developer IDE" \
      vendor="Code Server" \
      io.k8s.display-name="Code Server - Developer IDE" \
      io.openshift.expose-services="8080,codeserver" \
      io.openshift.tags="codeserver" \
      build-date="2022-06-30" \
      version=$CODE_SERVER_VERSION \
      release="1" \
      maintainer="Wolfgang Kulhanek <wkulhanek@redhat.com>"

RUN dnf -y update && \
    dnf -y install sudo git tar wget java-11-openjdk && \
    dnf -y install https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server-${CODE_SERVER_VERSION}-amd64.rpm && \
    dnf -y install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
    rm -rf /var/cache/dnf /root/.cache

# Install Maven
RUN wget -O /tmp/maven.tar.gz https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mkdir -p /usr/local/maven && tar -C /usr/local/maven --strip-components=1 -xzvf /tmp/maven.tar.gz && \
    ln -s /usr/local/maven/bin/mvn /usr/local/bin/mvn && \
    rm /tmp/maven.tar.gz

# Install OC CLI
RUN wget -O /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/stable-${OCP_VERSION}/openshift-client-linux.tar.gz && \
    tar -C /usr/bin -zxvf /tmp/oc.tar.gz && \
    rm /tmp/oc.tar.gz

COPY run-code-server.sh /usr/bin/run-code-server.sh

RUN adduser codeserver --home-dir=${CODE_SERVER_HOME} && \
    chmod 770 ${CODE_SERVER_HOME} && \
    chgrp 0 ${CODE_SERVER_HOME} && \
    chmod -R g=u ${CODE_SERVER_HOME} /etc/passwd && \
    chmod +x /usr/bin/run-code-server.sh

USER codeserver
WORKDIR ${CODE_SERVER_HOME}
VOLUME ${CODE_SERVER_HOME}

EXPOSE 8080

ENTRYPOINT ["/usr/bin/run-code-server.sh"]

# CMD ["code-server", "--config", "/home/codeserver/.config/code-server/config.yaml", "--user-data-dir", "/home/codeserver/repos/.local/share/code-server/User"]
CMD ["code-server"]
