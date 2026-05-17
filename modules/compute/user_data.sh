#!/bin/bash
# Direct standard output and errors to a dedicated deployment log file safely
exec > >(tee /var/log/user-data.log|logger -t user-data ) 2>&1

echo "Starting infrastructure bootstrap process..."

# Clear package caches and update repository indexes
yum update -y

# Install Nginx cleanly
yum install nginx -y

# Start and enable the Nginx web engine service
systemctl start nginx
systemctl enable nginx

# Create a clean enterprise landing page to satisfy the ALB Health Check path
echo "<h1>Enterprise Infrastructure Node Live</h1>" > /usr/share/nginx/html/index.html

echo "Bootstrap configuration phase completed successfully!"
