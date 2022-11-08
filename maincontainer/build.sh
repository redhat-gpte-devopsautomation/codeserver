#!/bin/bash
VERSION=v4.8.3
JAVA_VERSION=11
podman build . -t quay.io/gpte-devops-automation/codeserver:${VERSION}-java${JAVA_VERSION}
podman tag quay.io/gpte-devops-automation/codeserver:${VERSION}-java${JAVA_VERSION} quay.io/gpte-devops-automation/codeserver:latest
podman push quay.io/gpte-devops-automation/codeserver:latest
podman push quay.io/gpte-devops-automation/codeserver:${VERSION}-java${JAVA_VERSION}
