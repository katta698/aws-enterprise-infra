#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s2>/dev/console) 2>&1
yum update -y
dnf install -y docker
systemctl enable --now docker
docker run -d -p 80:80 --name sample-app nginx:alpine
docker exec sample-app sh -c "echo '<h1>Production Grade Deployment Complete - Host IP: '\$(hostname -I)'</h1>' > /usr/share/nginx/html/index.html"
