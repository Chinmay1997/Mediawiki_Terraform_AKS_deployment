apt update && apt upgrade
apt-get install apache2 mysql-server php php-mysql libapache2-mod-php php-xml php-mbstring php-intl -y
cd /tmp/
wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.1.tar.gz
tar -xvzf /tmp/mediawiki-*.tar.gz
mkdir /var/lib/mediawiki
mv mediawiki-*/* /var/lib/mediawiki
ln -s /var/lib/mediawiki /var/www/html/mediawiki
phpenmod mbstring
phpenmod xml
systemctl restart apache2.service
systemctl enable apache2