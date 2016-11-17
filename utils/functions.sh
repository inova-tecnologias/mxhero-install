#!/bin/bash

# backup of original config files
PREFIX_BKP=ori-bkp

BASEPATH=.
ROOTFS=$BASEPATH/rootfs

MAILDIR_MXHERO_PATH=opt/maildir-mxhero
ROUNDCUBE_PATH=opt/mxhero/web/roundcube
MXHERO_PATH=opt/mxhero

PACKAGES_PATH=packages

programname=$0
trap ctrl_c INT

function usage {
    echo "usage: $programname [-l file] [-s env]"
    echo "  -h          Display help"
    echo "  -v          Debug with set -x"
    echo "  -u          Uninstall"
    echo "  -l <filie>  License file"
    echo "  -s <env>    Skip a installation process"
    echo "  envs        FORCE_INSTALLATION - skips the port and package check"
    exit 1
}

function echo_title(){
    echo "===> $1"
}

function echo_subtitle(){
    echo "==>> $1"
}

function echo_thin_sub(){
    echo "=>>> $1"
}

function echo_sub(){
    echo "     $1"
}

function ctrl_c() {
        echo " "
        echo_subtitle "killing..."
        echo_subtitle "you may need to execute the script again!"
        exit 130 # CTRL C
}

function install_packages(){
    echo_thin_sub "installing common libs ..."
    # required for php5/spamassassin/clamav/libapache5/apache2
    dpkg -i $PACKAGES_PATH/libs/*.deb > /dev/null
    
    echo_thin_sub "installing perl packages ..."
    dpkg -i $PACKAGES_PATH/perl/*.deb > /dev/null
    
    echo_thin_sub "installing mysql-server packages ..."
    dpkg -i $PACKAGES_PATH/mysql-server/mysql-common_5.7.16-0ubuntu0.16.04.1_all.deb > /dev/null
    bash -c "DEBIAN_FRONTEND=noninteractive dpkg -i $PACKAGES_PATH/mysql-server/*.deb > /dev/null"

    echo_thin_sub "installing postfix packages ..."
    bash -c "DEBIAN_FRONTEND=noninteractive dpkg -i $PACKAGES_PATH/postfix/*.deb > /dev/null"
    
    echo_thin_sub "installing php5 packages ..."
    dpkg -i $PACKAGES_PATH/php5/*.deb > /dev/null 2>&1

    echo_thin_sub "installing spamassassin packages ..."
    dpkg -i $PACKAGES_PATH/spamassassin/*.deb > /dev/null
    
    echo_thin_sub "installing clamav packages ..." 
    dpkg -i $PACKAGES_PATH/clamav/*.deb > /dev/null

    echo_thin_sub "installing dovecot packages ..."
    dpkg -i $PACKAGES_PATH/dovecot/*.deb > /dev/null 2>&1

    echo_thin_sub "installing apache2 packages ..."
    dpkg -i $PACKAGES_PATH/apache2/*.deb > /dev/null

    echo_thin_sub "installing libapache5 packages ..."
    dpkg -i $PACKAGES_PATH/libapache2-mod-php5.5/libapache2-mod-php5.5_5.5.38-4+deb.sury.org~xenial+1_amd64.deb > /dev/null 2>&1
    
    systemctl stop apache2
    
    echo_thin_sub "installing nginx packages ..."
    dpkg -i $PACKAGES_PATH/nginx/*.deb > /dev/null

    echo_thin_sub "installing mxhero appliance ..."
    dpkg -i $PACKAGES_PATH/mxhero-amd64.deb > /dev/null
}


function purge_dependencies(){
    echo_sub "purging dependencies packages ..."
    
    dpkg --purge ssl-cert postfix-mysql postfix nginx-common libtiff5 libgd3 libwebp5 fonts-dejavu-core \
    fontconfig-config libvpx3 libfontconfig1 nginx-core libjbig0 libjpeg-turbo8 nginx libgd3 libjpeg8 \
    libxpm4 libapache2-mod-php5.5 libnet-dns-perl libtimedate-perl liblwp-mediatypes-perl libsocket6-perl \
    libio-html-perl libcgi-fast-perl libhtml-parser-perl libhtml-template-perl libhtml-tagset-perl \
    libhttp-date-perl libencode-locale-perl libcgi-pm-perl libfcgi-perl libhttp-message-perl libdigest-hmac-perl \
    libmail-spf-perl libnet-ip-perl liburi-perl libio-socket-inet6-perl apache2-bin apache2-data apache2 apache2-utils \
    mysql-client-5.7 mysql-server-5.7 mysql-common mysql-server mysql-client-core-5.7 mysql-server-core-5.7 libaio1 \
    libevent-core-2.0-5 clamav-base libcurl3 clamav clamav-freshclam gcc-5 libsys-hostname-long-perl libgcc-5-dev \
    libtsan0 cpp-5 libmpc3 cpp make libgomp1 re2c spamc manpages-dev libquadmath0 libmpx0 libisl15 sa-compile \
    linux-libc-dev libatomic1 libcc1-0 libasan2 gcc liblsan0 libc-dev-bin binutils spamassassin libc6-dev libitm1 \
    libubsan0 libcilkrts5 python3-mysqldb dovecot-core libexttextcat-2.0-0 libexttextcat-data dovecot-imapd \
    dovecot-mysql libnetaddr-ip-perl libmysqlclient20 libaprutil1 libapr1 libllvm3.6v5 libltdl7 libssl1.0.2 \
    libaprutil1-ldap liblua5.1-0 libaprutil1-dbd-sqlite3 libclamav7 libxslt1.1 php5.5-cli php5.5-opcache \
    php-common php5.5-readline php5.5-xml php5.5-json php5.5-common php5.5-mysql
}

function mxhero_prerequisites() {
    if [ -d /$MXHERO_PATH ]; then
        echo "FATAL! /$MXHERO_PATH exists"
        echo "FATAL! uninstall the package and remove the folder"
        echo ""
        exit 1
    fi 

    # Required ports for the installation, check if there are any services binding then
    for port in 25 26 143 5555 5556 4000 2401 9090 5701 8005 8009 8080 80 443 3306; do
        lsof -i :$port >/dev/null|| continue
        echo "FATAL! the port '$port' is in use!"
        echo "FATAL! cannot proceed with the installation!"
        echo "FATAL! exiting ..."
        echo ""
        exit 1
    done
 
    PACKAGE=
    for pkg in ssl-cert postfix-mysql postfix nginx-common libtiff5 libgd3 libwebp5 fonts-dejavu-core \
    fontconfig-config libvpx3 libfontconfig1 nginx-core libjbig0 libjpeg-turbo8 nginx libgd3 libjpeg8 \
    libxpm4 libapache2-mod-php5.5 libnet-dns-perl libtimedate-perl liblwp-mediatypes-perl libsocket6-perl \
    libio-html-perl libcgi-fast-perl libhtml-parser-perl libhtml-template-perl libhtml-tagset-perl \
    libhttp-date-perl libencode-locale-perl libcgi-pm-perl libfcgi-perl libhttp-message-perl libdigest-hmac-perl \
    libmail-spf-perl libnet-ip-perl liburi-perl libio-socket-inet6-perl apache2-bin apache2-data apache2 apache2-utils \
    mysql-client-5.7 mysql-server-5.7 mysql-common mysql-server mysql-client-core-5.7 mysql-server-core-5.7 libaio1 \
    libevent-core-2.0-5 clamav-base libcurl3 clamav clamav-freshclam gcc-5 libsys-hostname-long-perl libgcc-5-dev \
    libtsan0 cpp-5 libmpc3 cpp make libgomp1 re2c spamc manpages-dev libquadmath0 libmpx0 libisl15 sa-compile \
    linux-libc-dev libatomic1 libcc1-0 libasan2 gcc liblsan0 libc-dev-bin binutils spamassassin libc6-dev libitm1 \
    libubsan0 libcilkrts5 python3-mysqldb dovecot-core libexttextcat-2.0-0 libexttextcat-data dovecot-imapd \
    dovecot-mysql libnetaddr-ip-perl libmysqlclient20 libaprutil1 libapr1 libllvm3.6v5 libltdl7 libssl1.0.2 \
    libaprutil1-ldap liblua5.1-0 libaprutil1-dbd-sqlite3 libclamav7 libxslt1.1 php5.5-cli php5.5-opcache \
    php-common php5.5-readline php5.5-xml php5.5-json php5.5-common php5.5-mysql mxhero; do
        # If the package is not found, check the next one,
        # otherwise set the a variable and break the loop
        dpkg -l |grep "$package\s" >/dev/null || continue && PACKAGE=$pkg && break
    done

    # We found a package installed on the server, warn the user
    if [ -z $PACKAGE ]; then
        echo ""
        echo "WARNING! the package '$package' is already installed!"
        echo "WARNING! this is not a fresh install or a package is already installed and in use!"
        echo "WARNING! mxHero requires to be installed on a clean server"
        echo "WARNING! THE INSTALLED PACKAGES WILL BE MODIFIED!"
        echo "WARNING! ONLY PROCEED IF YOU KNOW WHAT ARE YOU DOING!"
        echo ""
        echo "press (Y) to continue or (N) to cancel ..."
        echo -n "> "
        read key
        if [[ $key != "Y" ]]; then
            echo "exiting the installation script ..."
            echo ""
            exit 1
        fi
        echo "the installation will proceed in 5 seconds ..."
        echo ""
        # Give time for the user to cancel using ctrl_C
        sleep 5
    fi
}

function uninstall() {
    purge_dependencies
    dpkg --purge mxhero
    deluser mxhero

    echo_sub "dropping databases and users ..."
    /usr/bin/mysql -u root -Bse "DROP DATABASE IF EXISTS attachments"
    /usr/bin/mysql -u root -Bse "DROP DATABASE IF EXISTS mxhero"
    /usr/bin/mysql -u root -Bse "DROP DATABASE IF EXISTS quarantine"
    /usr/bin/mysql -u root -Bse "DROP DATABASE IF EXISTS roundcubemail"
    /usr/bin/mysql -u root -Bse "DROP DATABASE IF EXISTS secureemail"
    /usr/bin/mysql -u root -Bse "DROP DATABASE IF EXISTS statistics"
    /usr/bin/mysql -u root -Bse "DROP DATABASE IF EXISTS text2image"
    /usr/bin/mysql -u root -Bse "DROP DATABASE IF EXISTS threadlight"

    /usr/bin/mysql -u root -Bse "DROP USER IF EXISTS attachments"
    /usr/bin/mysql -u root -Bse "DROP USER IF EXISTS mxhero"
    /usr/bin/mysql -u root -Bse "DROP USER IF EXISTS statistics"
    /usr/bin/mysql -u root -Bse "DROP USER IF EXISTS threadlight"
    /usr/bin/mysql -u root -Bse "FLUSH PRIVILEGES"

    rm -rf /$MAILDIR_MXHERO_PATH
    rm -rf /$MXHERO_PATH

    echo "==============="
    echo "uninstall finished successfully!"
    echo "remove package folders below manually"
    echo "/etc/apache2"
    echo "/etc/nginx"
    echo "/etc/dovecot"
    echo "/etc/postfix"
    echo "/etc/postfix-mxh"
}

function create_databases(){
    /usr/bin/mysql -u root -Bse "CREATE DATABASE IF NOT EXISTS attachments"
    /usr/bin/mysql -u root -Bse "CREATE DATABASE IF NOT EXISTS mxhero"
    /usr/bin/mysql -u root -Bse "CREATE DATABASE IF NOT EXISTS quarantine"
    /usr/bin/mysql -u root -Bse "CREATE DATABASE IF NOT EXISTS roundcubemail"
    /usr/bin/mysql -u root -Bse "CREATE DATABASE IF NOT EXISTS secureemail"
    /usr/bin/mysql -u root -Bse "CREATE DATABASE IF NOT EXISTS statistics"
    /usr/bin/mysql -u root -Bse "CREATE DATABASE IF NOT EXISTS text2image"
    /usr/bin/mysql -u root -Bse "CREATE DATABASE IF NOT EXISTS threadlight"
    
    echo_sub "loading schemas ..."
    /usr/bin/mysql -u root -D attachments < $BASEPATH/data/attachments.sql
    /usr/bin/mysql -u root -D mxhero < $BASEPATH/data/mxhero.sql
    /usr/bin/mysql -u root -D quarantine < $BASEPATH/data/quarantine.sql
    /usr/bin/mysql -u root -D roundcubemail < $BASEPATH/data/roundcubemail.sql
    /usr/bin/mysql -u root -D secureemail < $BASEPATH/data/secureemail.sql
    /usr/bin/mysql -u root -D statistics < $BASEPATH/data/statistics-schema.sql
    /usr/bin/mysql -u root -D text2image < $BASEPATH/data/text2image.sql
    /usr/bin/mysql -u root -D threadlight < $BASEPATH/data/threadlight.sql

    echo_sub "loading procedures and events ..."
    /usr/bin/mysql -u root -D mxhero < $BASEPATH/data/functions/mxhero.sql
    /usr/bin/mysql -u root -D secureemail < $BASEPATH/data/functions/secureemail.sql
    /usr/bin/mysql -u root -D statistics < $BASEPATH/data/functions/statistics.sql
    /usr/bin/mysql -u root -D threadlight < $BASEPATH/data/functions/threadlight.sql

}

function create_default_database_users(){
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON attachments.* TO attachmentlink@'localhost' IDENTIFIED BY 'attachmentlink'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON mxhero.* TO mxhero@'localhost' IDENTIFIED BY 'mxhero'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON mxhero.* TO mxhero@'%' IDENTIFIED BY 'mxhero'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON roundcubemail.* TO 'mxhero'@'%'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON attachments.* TO 'mxhero'@'%'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON statistics.* TO 'mxhero'@'%'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON threadlight.* TO 'mxhero'@'%'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON text2image.* TO 'mxhero'@'%'"
    /usr/bin/mysql -u root -Bse "FLUSH PRIVILEGES"
}

function create_linux_user(){
    id mxhero >/dev/null 2>/dev/null || \
    adduser --gecos "" --no-create-home --disabled-password --quiet --shell /bin/bash mxhero
}

function install_license(){
    echo "install license"
}

function configure_mysql(){
    cp $ROOTFS/etc/mysql/mysql.conf.d/mxhero.conf /etc/mysql/mysql.conf.d/mxhero.conf
    # Total memory in KiloBytes
    TOTALMEMORY=$(grep MemTotal: /proc/meminfo |awk {'print $2'})
    INNODBPOOLSIZE=$(echo "$(($TOTALMEMORY * 30 / 100))")
    sed -i "s|INNODBPOOLSIZE|$INNODBPOOLSIZE|g" /etc/mysql/mysql.conf.d/mxhero.conf
    echo_sub "restarting mysql ..."
    systemctl restart mysql 
}

function configure_postfix(){
    MYNETWORKS=$1
    POSTFIX_PATH=etc/postfix
    # Backup origin conf file
    cp /$POSTFIX_PATH/main.cf /$POSTFIX_PATH/main.cf-$PREFIX_BKP

    cp $ROOTFS/$POSTFIX_PATH/main.cf /$POSTFIX_PATH/main.cf
    # Required for configuring multiple instances of postfix
    # `man postmulti` or http://www.postfix.org/MULTI_INSTANCE_README.html for more info
    cp $ROOTFS/$POSTFIX_PATH/main.cf.proto /$POSTFIX_PATH/main.cf.proto
    cp $ROOTFS/$POSTFIX_PATH/master.cf.proto /$POSTFIX_PATH/master.cf.proto
    
    # sql files
    mkdir -p /etc/postfix/mxhero
    cp $ROOTFS/$POSTFIX_PATH/mxhero/*.sql /$POSTFIX_PATH/mxhero/

    sed -i "s|MXHEROMYNETWORKS|$MYNETWORKS|g" /$POSTFIX_PATH/main.cf.proto /$POSTFIX_PATH/main.cf
    sed -i "s/MXHEROHOSTNAME/`hostname`/g" /$POSTFIX_PATH/main.cf.proto /$POSTFIX_PATH/main.cf

    postmulti -e init 
    postmulti -I postfix-mxh -G mxhero -e create 2> /dev/null
    postmulti -i postfix-mxh -e enable

    sed -i 's/^master_service_disable = inet/#master_service_disable = inet/g' /etc/postfix-mxh/main.cf 
    sed -i 's/^authorized_submit_users = /#authorized_submit_users = /g' /etc/postfix-mxh/main.cf

    echo_sub "restarting postfix ..."
    systemctl restart postfix
}

function configure_mxhero(){
    mkdir -m 0750 -p /$MAILDIR_MXHERO_PATH
    chown mxhero: -R /$MAILDIR_MXHERO_PATH
    chown mxhero: -R /$MXHERO_PATH
    echo_sub "enabling smtpd proxy/web systemd services ..."
    systemctl enable mxhero
    systemctl enable mxheroweb
}

function configure_roundcube(){    
    # Backup origin conf file
    cp /etc/apache2/ports.conf /etc/apache2/ports.conf-$PREFIX_BKP

    cp $ROOTFS/etc/apache2/sites-enabled/roundcube.conf /etc/apache2/sites-enabled/roundcube.conf
    cp $ROOTFS/etc/apache2/ports.conf /etc/apache2/ports.conf

    ln -s /$MXHERO_PATH/web/roundcube /var/www/roundcube || true
    chown www-data: -R /var/www

    echo_sub "restarting apache2 service ..."
    systemctl restart apache2
}

function configure_dovecot(){
    echo_subtitle "configuring dovecot ..."
    MXHERO_USER_ID=$(id mxhero -u)
    DOVECOT_CONF_PATH=/etc/dovecot/conf.d
    
    # Backup original config files first
    cp $DOVECOT_CONF_PATH/10-auth.conf $DOVECOT_CONF_PATH/10-auth.conf-$PREFIX_BKP
    cp $DOVECOT_CONF_PATH/10-mail.conf $DOVECOT_CONF_PATH/10-mail.conf-$PREFIX_BKP
    cp /etc/dovecot/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext-$PREFIX_BKP

    cp $ROOTFS/etc/dovecot/dovecot-sql.conf.ext /etc/dovecot/dovecot-sql.conf.ext

    sed -i 's/#!include auth-sql.conf.ext/!include auth-sql.conf.ext/g' $DOVECOT_CONF_PATH/10-auth.conf
    sed -i 's/#!include auth-master.conf.ext/!include auth-master.conf.ext/g' $DOVECOT_CONF_PATH/10-auth.conf
    sed -i 's/\#auth_master_user_separator=/auth_master_user_separator=/g' $DOVECOT_CONF_PATH/10-auth.conf

    sed -i 's/#valid_chroot_dirs =/valid_chroot_dirs = \/opt\/maildir-mxhero\/%d/g' $DOVECOT_CONF_PATH/10-mail.conf
    sed -i "s/#first_valid_gid.*/first_valid_gid=${MXHERO_USER_ID}/g" $DOVECOT_CONF_PATH/10-mail.conf
    sed -i 's/^mail_location.*/mail_location = maildir:\/opt\/maildir-mxhero\/%d\/%n/g' $DOVECOT_CONF_PATH/10-mail.conf

    # Create an delegated admin account
    htpasswd -b -c -s /etc/dovecot/master-users mxhero mxhero 2> /dev/null
    echo_sub "restarting dovecot service ..."
    systemctl restart dovecot

    echo_sub "done configuring dovecot!"
}

function configure_nginx() {
    cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default-$PREFIX_BKP
    cp $ROOTFS/etc/nginx/conf.d/mxhero.conf /etc/nginx/sites-available/default
    echo_sub "restarting nginx proxy ..."
    systemctl restart nginx
}

function configure_server_time(){
    timedatectl set-timezone Etc/UTC
}

function configure_environment_lang(){
    cat << EOF > /etc/environment
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
LANG="en_US.UTF-8"
LC_MESSAGES="C"
LC_ALL="en_US.UTF-8"
EOF
    source /etc/environment
}

function configure_security_limits(){
    grep ^mxhero /etc/security/limits.conf || \
    echo -e "mxhero soft nofile 524288\nmxhero soft nofile 524288" >> /etc/security/limits.conf > /dev/null
    grep ^root /etc/security/limits.conf || \
    echo -e "root soft nofile 524288\nroot soft nofile 524288" >> /etc/security/limits.conf > /dev/null
}

function installation_notes() {
    echo "==============="
    echo "if you wish to install the mxHero zimlet (Zimbra Only)"
    echo "run the command on every mailbox server:"
    echo "wget https://s3.amazonaws.com/mxhero/com_mxhero_zimlet.zip -O /tmp/com_mxhero_zimlet.zip && zmzimletctl deploy /tmp/com_mxhero_zimlet.zip"

    echo "run on a single mailbox server:" 
    echo 'zmprov mcf +zimbraCustomMimeHeaderNameAllowed X-mxHero-Actions'
    echo 'zmprov mcf +zimbraCustomMimeHeaderNameAllowed X-mxHero-Action-AttachmentTrack'
    echo 'zmprov mcf +zimbraCustomMimeHeaderNameAllowed X-mxHero-Action-ReplyTimeout'
    echo 'zmprov mcf +zimbraCustomMimeHeaderNameAllowed X-mxHero-Action-ReadOnce'
    echo 'zmprov mcf +zimbraCustomMimeHeaderNameAllowed X-mxHero-Action-EnhancedBcc'
    echo 'zmprov mcf +zimbraCustomMimeHeaderNameAllowed X-mxHero-Action-SendAsPersonal'
    echo 'zmprov mcf +zimbraCustomMimeHeaderNameAllowed X-mxHero-Action-SecureEmail'
    echo 'zmprov mcf +zimbraCustomMimeHeaderNameAllowed X-mxHero-Action-PrivateDelivery'
    echo 'zmprov mcf +zimbraCustomMimeHeaderNameAllowed X-mxHero-Action-SelfDestruct'
}
