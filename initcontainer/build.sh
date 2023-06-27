#!/bin/bash
VERSION=4.14.1
podman build . -t quay.io/gpte-devops-automation/codeserver-init:latest
podman tag quay.io/gpte-devops-automation/codeserver-init:latest quay.io/gpte-devops-automation/codeserver-init:v${VERSION}
podman push quay.io/gpte-devops-automation/codeserver-init:latest
podman push quay.io/gpte-devops-automation/codeserver-init:v${VERSION}
