#!/bin/bash
VERSION=4.5.1
podman build . -t quay.io/gpte-devops-automation/codeserver:latest
podman tag quay.io/gpte-devops-automation/codeserver:latest quay.io/gpte-devops-automation/codeserver:v${VERSION}
podman push quay.io/gpte-devops-automation/codeserver:latest
podman push quay.io/gpte-devops-automation/codeserver:v${VERSION}
