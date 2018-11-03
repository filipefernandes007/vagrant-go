#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

MY_DB=${DB}
MY_SQL_PASSWORD="root"

# ---------------------------------------
#          MySQL Setup
# ---------------------------------------

# # Import MySQL 5.7 Key
# # gpg: key 5072E1F5: public key "MySQL Release Engineering <mysql-build@oss.oracle.com>" imported
apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 5072E1F5 2> /dev/null
echo "deb http://repo.mysql.com/apt/ubuntu/ xenial mysql-5.7" | tee -a /etc/apt/sources.list.d/mysql.list

debconf-set-selections <<< "mysql-community-server mysql-community-server/data-dir select ''"
debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

apt-get -o Dpkg::Progress-Fancy="1" install -q -y mysql-server 2> /dev/null
apt-get -o Dpkg::Progress-Fancy="1" install -q -y mysql-client-core-5.7 2> /dev/null

# Allow External Connections on your MySQL Service

#sudo sed -i -e 's/bind-addres/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
#sudo sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';"
sudo mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root'; FLUSH privileges;"
mysqladmin -p -u root -proot version

sudo service mysql restart

# create client database
mysql -u root -proot -e "CREATE DATABASE $MY_DB;"

service mysql restart

echo "[Mysql users]"
echo "User : root $MY_SQL_PASSWORD"
echo "Database : $MY_DB $MY_SQL_PASSWORD"
