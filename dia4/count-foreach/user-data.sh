#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
echo "<html><body><div>Ola, Mundo</div></body></html>" > /var/www/html/index.html
