#! /bin/bash
set -e

ls -ltr
#giving permissions to /tmp folder
sudo chmod  777 -R /tmp

sudo cd /tmp

#validation GPG keys
sudo cat /etc/yum.repos.d/google-cloud.repo
sudo sed -i 's/repo_gpgcheck=1/repo_gpgcheck=0/g' /etc/yum.repos.d/google-cloud.repo

#installing gpg packages
sudo yum -y install httpd php php-mysql php-gd mariadb-server php-xml php-intl mysql

#starting the services
sudo systemctl start mariadb
sudo systemctl restart httpd.service
sudo systemctl enable httpd.service

#sql queries
sudo mysql -u root -p '123'<<-EOF
CREATE DATABASE SQLDB;
CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'THISpasswordSHOULDbeCHANGED';
GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';
SHOW DATABASES;
SHOW GRANTS FOR 'wiki'@'localhost';
FLUSH PRIVILEGES;
EOF

#installing wget
sudo yum -y install wget

#installing mediawiki
sudo wget https://releases.wikimedia.org/mediawiki/1.24/mediawiki-1.24.2.tar.gz
sudo tar -zxpvf mediawiki-1.24.2.tar.gz
sudo chmod -R 777 /var/www/html
sudo mv mediawiki-1.24.2 /var/www/html/mediawiki

#changing user to apache
sudo chown -R apache:apache /var/www/html/mediawiki/
sudo chmod 755 /var/www/html/mediawiki/

#opening port and firewall
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
sudo firewall-cmd --reload
#iptables-save | grep 80
sudo getenforce
sudo restorecon -FR /var/www/html/mediawiki/
