#!/bin/bash
echo "${mensagem}" > index.html
nohup busybox httpd -f -p ${server_port} &