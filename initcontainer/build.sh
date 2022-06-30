#!/bin/bash
podman build . -t quay.io/gpte-devops-automation/codeserver-init:latest
podman push quay.io/gpte-devops-automation/codeserver-init:latest
