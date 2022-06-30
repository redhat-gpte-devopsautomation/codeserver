#!/bin/bash
podman build . -t quay.io/gpte-devops-automation/codeserver:latest
podman push quay.io/gpte-devops-automation/codeserver:latest
