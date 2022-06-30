#!/bin/bash
oc adm new-project codeserver-user1
oc apply -k ./k8s -n codeserver-user1
