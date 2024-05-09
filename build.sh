#!/bin/bash
CODE_SERVER_VERSION="4.89.0"
IMAGE_VERSION="v${CODE_SERVER_VERSION}"
MAVEN_VERSION="3.9.6"
OCP_VERSION="4.15"
BUILD_DATE=$(date +"%Y-%m-%d")

cd initcontainer
podman build . \
  --build-arg CODE_SERVER_VERSION=${CODE_SERVER_VERSION} \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/gpte-devops-automation/codeserver-init:latest

podman tag quay.io/gpte-devops-automation/codeserver-init:latest quay.io/gpte-devops-automation/codeserver-init:${IMAGE_VERSION}
podman push quay.io/gpte-devops-automation/codeserver-init:latest
podman push quay.io/gpte-devops-automation/codeserver-init:${IMAGE_VERSION}

cd ../maincontainer
# Build for Java 11
podman build . \
  --build-arg CODE_SERVER_VERSION=${CODE_SERVER_VERSION} \
  --build-arg MAVEN_VERSION=${MAVEN_VERSION} \
  --build-arg OCP_VERSION=${OCP_VERSION} \
  --build-arg JAVA_VERSION="11" \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java11
podman push quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java11

# Build for Java 17
podman build . \
  --build-arg CODE_SERVER_VERSION=${CODE_SERVER_VERSION} \
  --build-arg MAVEN_VERSION=${MAVEN_VERSION} \
  --build-arg OCP_VERSION=${OCP_VERSION} \
  --build-arg JAVA_VERSION="17" \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java17
podman tag quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java17 quay.io/gpte-devops-automation/codeserver:latest
podman push quay.io/gpte-devops-automation/codeserver:latest
podman push quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java17

cd ..
