#!/bin/bash

# Updated /etc/passwd with current UID of the running container
grep -v ^codeserver /etc/passwd > "/tmp/passwd"
echo "codeserver:x:$(id -u):0:codeserver user:/home/codeserver:/bin/bash" >> /tmp/passwd
cat /tmp/passwd >/etc/passwd
rm /tmp/passwd

# Set a few environment variables to make Codeserver behave
export USER=codeserver
export USERNAME=codeserver
export HOME=/home/codeserver

# Start Code Server
exec "$@"
