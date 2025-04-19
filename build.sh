#!/bin/bash
CODE_SERVER_VERSION="4.99.3"
IMAGE_VERSION="v${CODE_SERVER_VERSION}"
MAVEN_VERSION="3.9.9"
OCP_VERSION="4.18"
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
# Build base image
podman build . \
  --file Containerfile-base \
  --build-arg CODE_SERVER_VERSION=${CODE_SERVER_VERSION} \
  --build-arg MAVEN_VERSION=${MAVEN_VERSION} \
  --build-arg OCP_VERSION=${OCP_VERSION} \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}:latest

# Build for Java 11
JAVA_VERSION=11
podman build . \
  --build-arg JAVA_VERSION="${JAVA_VERSION}" \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java${JAVA_VERSION}
podman push quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java${JAVA_VERSION}

# Build for Java 17
JAVA_VERSION=17
podman build . \
  --build-arg JAVA_VERSION="${JAVA_VERSION}" \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java${JAVA_VERSION}
podman push quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java${JAVA_VERSION}

# Build for Java 21
JAVA_VERSION=21
podman build . \
  --build-arg JAVA_VERSION="${JAVA_VERSION}" \
  --build-arg BUILD_DATE=${BUILD_DATE} \
  --tag quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java${JAVA_VERSION}
podman push quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java${JAVA_VERSION}
podman tag quay.io/gpte-devops-automation/codeserver:${IMAGE_VERSION}-java${JAVA_VERSION} quay.io/gpte-devops-automation/codeserver:latest
podman push quay.io/gpte-devops-automation/codeserver:latest

cd ..
