#!/bin/bash
CODE_SERVER_VERSION=v4.18.0
JAVA_VERSION=11
MAVEN_VERSION="3.8.8"
OCP_VERSION="4.14"
BUILD_DATE=$(date +"%Y-%m-%d")

cd initcontainer
podman build . \
  --build-arg CODE_SERVER_VERSION=${CODE_SERVER_VERSION} \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/gpte-devops-automation/codeserver-init:latest

podman tag quay.io/gpte-devops-automation/codeserver-init:latest quay.io/gpte-devops-automation/codeserver-init:v${CODE_SERVER_VERSION}
podman push quay.io/gpte-devops-automation/codeserver-init:latest
podman push quay.io/gpte-devops-automation/codeserver-init:v${CODE_SERVER_VERSION}

cd ../maincontainer
podman build . \
  --build-arg CODE_SERVER_VERSION=${CODE_SERVER_VERSION} \
  --build-arg JAVA_VERSION=${JAVA_VERSION} \
  --build-arg MAVEN_VERSION=${MAVEN_VERSION} \
  --build-arg OCP_VERSION=${OCP_VERSION} \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/gpte-devops-automation/codeserver:${CODE_SERVER_VERSION}-java${JAVA_VERSION}
podman tag quay.io/gpte-devops-automation/codeserver:${CODE_SERVER_VERSION}-java${JAVA_VERSION} quay.io/gpte-devops-automation/codeserver:latest
podman push quay.io/gpte-devops-automation/codeserver:latest
podman push quay.io/gpte-devops-automation/codeserver:${CODE_SERVER_VERSION}-java${JAVA_VERSION}

cd ..
