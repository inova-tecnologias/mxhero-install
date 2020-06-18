#!/bin/bash
MYNETWORKS="10.0.0.0/8 192.168.0.0/16 127.0.0.0/8"
GLOBAL_ADMIN_PASSWD=mxheroadmin
MYSQL_ROOT_PASSWD=root

function usage()
{
    echo "MXGateway Installer"
    echo "Usage: $0 [ARGS]"
    echo -e "\t-h --help: Show this help menu"
    echo -e "\t-n --mynetworks: Postfix Mynetworks. Default: $MYNETWORKS"
    echo -e "\t-a --admin: Global admin password. Default: $GLOBAL_ADMIN_PASSWD"
    echo -e "\t-m --mysql: Mysql root password. Default: $MYSQL_ROOT_PASSWD"
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -n | --mynetworks)
            MYNETWORKS=$VALUE
            ;;
        -a | --admin)
            GLOBAL_ADMIN_PASSWD=$VALUE
            ;;
        -m | --mysql)
            MYSQL_ROOT_PASSWD=$VALUE
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

apt-get update
apt-get install dialog

# PERL
apt-get -y install perl
apt-get -y install \
libcgi-fast-perl \
libfcgi-perl \
libhttp-date-perl \
liblwp-mediatypes-perl \
libsocket6-perl \
libcgi-pm-perl \
libhtml-parser-perl \
libhttp-message-perl \
libmail-spf-perl \
libtimedate-perl \
libdigest-hmac-perl \
libhtml-tagset-perl \
libio-html-perl \
libnet-dns-perl \
liburi-perl \
libencode-locale-perl \
libhtml-template-perl \
libio-socket-inet6-perl \
libnet-ip-perl

# MYSQL
echo "deb http://cn.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list

echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWD" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWD" | debconf-set-selections

apt-get -y install mysql-server-5.7

# POSTFIX
DEBIAN_FRONTEND=noninteractive
apt-get -y install postfix postfix-mysql

# PHP
apt-get -y install software-properties-common
add-apt-repository ppa:ondrej/php -y || true
apt-get update
apt-get -y install php5.6 --allow-unauthenticated
apt-get -y install php5.6-mysql php5.6-xml --allow-unauthenticated

# spamassassin
apt-get install -y spamassassin

# clamav
apt-get install -y clamav

# dovecot
apt-get install -y dovecot-core dovecot-imapd dovecot-mysql

# apache2
apt-get install -y apache2 libapache2-mod-php5.6

# nginx
/etc/init.d/apache2 stop
apt-get install -y nginx --allow-unauthenticated
apt-get install -y libvpx3 libwebp5

# mxhero
apt-get -y install wget
wget https://s3.amazonaws.com/mxhero/releases/mxhero_2.2.4_amd64.deb \
&& dpkg -i mxhero_2.2.4_amd64.deb

# Python
apt-get -y install python
# CONFIGURE SECURITY LIMITS
grep ^mxhero /etc/security/limits.conf || \
echo -e "mxhero soft nofile 524288\nmxhero soft nofile 524288" >> /etc/security/limits.conf
grep ^root /etc/security/limits.conf || \
echo -e "root soft nofile 524288\nroot soft nofile 524288" >> /etc/security/limits.conf

# CREATE MXHERO USER
id mxhero >/dev/null 2>/dev/null || \
adduser --gecos "" --no-create-home --disabled-password --quiet --shell /bin/bash mxhero

# CONFIGURE MXHERO
mkdir -m 0750 -p /opt/maildir-mxhero && \ 
chown -R mxhero: /opt/maildir-mxhero && \
chown -R mxhero: /opt/mxhero
/bin/systemctl enable mxhero && /bin/systemctl enable mxheroweb

# CONFIGURE ROUNDCUBE
rm -f /etc/apache2/sites-enabled/* \
          /etc/apache2/ports.conf

cp apache2/sites-enabled/roundcube.conf /etc/apache2/sites-enabled/
cp apache2/ports.conf /etc/apache2/

ln -s /opt/mxhero/web/roundcube /var/www/roundcube
chown www-data: -R /var/www
/etc/init.d/apache2 restart

# CONFIGURE DOVECOT
cp -f dovecot/dovecot-sql.conf.ext /etc/dovecot/
sed -i 's/#!include auth-sql.conf.ext/!include auth-sql.conf.ext/g' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/#!include auth-master.conf.ext/!include auth-master.conf.ext/g' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/\#auth_master_user_separator =.*/auth_master_user_separator = \*/g' /etc/dovecot/conf.d/10-auth.conf
sed -i 's/#valid_chroot_dirs =/valid_chroot_dirs = \/opt\/maildir-mxhero\/%d/g' /etc/dovecot/conf.d/10-mail.conf
sed -i "s/#first_valid_gid.*/first_valid_gid=$(id mxhero -u)/g" /etc/dovecot/conf.d/10-mail.conf
sed -i 's/^mail_location.*/mail_location = maildir:\/opt\/maildir-mxhero\/%d\/%n/g' /etc/dovecot/conf.d/10-mail.conf
sed -i "s/MXHEROUID/$(id mxhero -u)/g" /etc/dovecot/dovecot-sql.conf.ext
htpasswd -b -c -s /etc/dovecot/master-users mxhero mxhero
/etc/init.d/dovecot restart

# CONFIGURE POSTFIX
cp -rf  postfix/* /etc/postfix/

sed -i "s|MXHEROMYNETWORKS|$MYNETWORKS|g" /etc/postfix/main.cf.proto /etc/postfix/main.cf
sed -i "s/MXHEROHOSTNAME/`hostname`/g" /etc/postfix/main.cf.proto /etc/postfix/main.cf

postmulti -e init 
postmulti -I postfix-mxh -G mxhero -e create 2> /dev/null
postmulti -i postfix-mxh -e enable

sed -i 's/^master_service_disable = inet/#master_service_disable = inet/g' /etc/postfix-mxh/main.cf 
sed -i 's/^authorized_submit_users = /#authorized_submit_users = /g' /etc/postfix-mxh/main.cf

/etc/init.d/postfix restart

# CONFIGURE MYSQL

cp mysql/mysql.conf.d/mxhero.conf /etc/mysql/mysql.conf.d/
TOTALMEMORY=$(grep MemTotal: /proc/meminfo |awk {'print $2'}); \
INNODBPOOLSIZE=$(echo "$(($TOTALMEMORY * 30 / 100))"); \
sed -i "s|INNODBPOOLSIZE|$INNODBPOOLSIZE|g" /etc/mysql/mysql.conf.d/mxhero.conf

# INITIALIZE MYSQL
sed -i "s/GLOBAL_ADMIN_PASSWORD/$GLOBAL_ADMIN_PASSWD/g" data/mxhero.sql
# # CREATE DATABASES
/usr/bin/mysql -u root -proot -Bse "CREATE DATABASE IF NOT EXISTS attachments"
/usr/bin/mysql -u root -proot -Bse "CREATE DATABASE IF NOT EXISTS mxhero"
/usr/bin/mysql -u root -proot -Bse "CREATE DATABASE IF NOT EXISTS quarantine"
/usr/bin/mysql -u root -proot -Bse "CREATE DATABASE IF NOT EXISTS roundcubemail"
/usr/bin/mysql -u root -proot -Bse "CREATE DATABASE IF NOT EXISTS secureemail"
/usr/bin/mysql -u root -proot -Bse "CREATE DATABASE IF NOT EXISTS statistics"
/usr/bin/mysql -u root -proot -Bse "CREATE DATABASE IF NOT EXISTS text2image"
/usr/bin/mysql -u root -proot -Bse "CREATE DATABASE IF NOT EXISTS threadlight"
# # POPULATE
/usr/bin/mysql -u root -proot -D attachments < data/attachments.sql
/usr/bin/mysql -u root -proot -D mxhero < data/mxhero.sql
/usr/bin/mysql -u root -proot -D quarantine < data/quarantine.sql
/usr/bin/mysql -u root -proot -D roundcubemail < data/roundcubemail.sql
/usr/bin/mysql -u root -proot -D secureemail < data/secureemail.sql
/usr/bin/mysql -u root -proot -D statistics < data/statistics-schema.sql
/usr/bin/mysql -u root -proot -D text2image < data/text2image.sql
/usr/bin/mysql -u root -proot -D threadlight < data/threadlight.sql
/usr/bin/mysql -u root -proot -D mxhero < data/functions/mxhero.sql
/usr/bin/mysql -u root -proot -D secureemail < data/functions/secureemail.sql
/usr/bin/mysql -u root -proot -D statistics < data/functions/statistics.sql
/usr/bin/mysql -u root -proot -D threadlight < data/functions/threadlight.sql
# # CREATE USERS
/usr/bin/mysql -u root -proot -Bse "GRANT ALL PRIVILEGES ON attachments.* TO attachmentlink@'localhost' IDENTIFIED BY 'attachmentlink'"
/usr/bin/mysql -u root -proot -Bse "GRANT ALL PRIVILEGES ON mxhero.* TO mxhero@'localhost' IDENTIFIED BY 'mxhero'"
/usr/bin/mysql -u root -proot -Bse "GRANT ALL PRIVILEGES ON mxhero.* TO mxhero@'%' IDENTIFIED BY 'mxhero'"
/usr/bin/mysql -u root -proot -Bse "GRANT ALL PRIVILEGES ON roundcubemail.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -proot -Bse "GRANT ALL PRIVILEGES ON attachments.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -proot -Bse "GRANT ALL PRIVILEGES ON statistics.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -proot -Bse "GRANT ALL PRIVILEGES ON threadlight.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -proot -Bse "GRANT ALL PRIVILEGES ON text2image.* TO 'mxhero'@'%'"
/usr/bin/mysql -u root -proot -Bse "FLUSH PRIVILEGES"

# CONFIGURE NGINX
cp -f nginx/conf.d/mxhero.conf /etc/nginx/sites-available/default
/etc/init.d/nginx restart

# START HERO
systemctl start mxheroweb
systemctl start mxhero


