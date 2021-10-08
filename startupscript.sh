#!/bin/bash
# Simple shell script to install nginx and certbot and also tuning nginx performance

sudo apt-get update
sudo apt-get install -y nginx certbot python3-certbot-nginx
sleep 2m
sudo certbot --nginx -n \
     -d dev.codezonebd.com \
     -d www.dev.codezonebd.com \
     --redirect --agree-tos --email mahiuddinalkamal@gmail.com # change domain names, email to your own
sudo service nginx reload
sudo sh -c "echo 'test-user soft nofile 30000' >> /etc/security/limits.conf" # for increasing soft file open limit for current user
sudo sh -c "echo 'test-user hard nofile 30000' >> /etc/security/limits.conf" # for increasing hard file open limit for current user
sysctl -p
sudo sh -c "echo 'worker_rlimit_nofile 30000;' >> /etc/nginx/nginx.conf" # for allowing nginx worker to open more files
sudo sed -i 's/worker_connections 768;/worker_connections 20000;/g' /etc/nginx/nginx.conf # for allowing nginx workers to have more conncetions
sudo service nginx restart
