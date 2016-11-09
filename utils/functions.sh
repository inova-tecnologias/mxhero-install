#!/bin/bash

# backup of original config files
PREFIX_BKP=ori-bkp

BASEPATH=.
ROOTFS=$BASEPATH/rootfs

MAILDIR_MXHERO_PATH=opt/maildir-mxhero
ROUNDCUBE_PATH=opt/mxhero/web/roundcube
MXHERO_PATH=opt/mxhero

PACKAGES_PATH=packages

trap ctrl_c INT

function echo_title(){
    echo "===> $1"
}

function echo_subtitle(){
    echo "==>> $1"
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
    # MySQL packages
    dpkg -i $PACKAGES_PATH/mysql-server/mysql-common_5.7.16-0ubuntu0.16.04.1_all.deb
    dpkg -i $PACKAGES_PATH/mysql-server/libaio1_0.3.110-2_amd64.deb
    dpkg -i $PACKAGES_PATH/mysql-server/libevent-core-2.0-5_2.0.21-stable-2_amd64.deb
    dpkg -i $PACKAGES_PATH/mysql-server/libhtml-template-perl_2.95-2_all.deb
    dpkg -i $PACKAGES_PATH/mysql-server/mysql-client-core-5.7_5.7.16-0ubuntu0.16.04.1_amd64.deb
    dpkg -i $PACKAGES_PATH/mysql-server/mysql-client-5.7_5.7.16-0ubuntu0.16.04.1_amd64.deb
    dpkg -i $PACKAGES_PATH/mysql-server/mysql-server-core-5.7_5.7.16-0ubuntu0.16.04.1_amd64.deb
    dpkg -i $PACKAGES_PATH/mysql-server/mysql-server-5.7_5.7.16-0ubuntu0.16.04.1_amd64.deb
    dpkg -i $PACKAGES_PATH/mysql-server/mysql-server_5.7.16-0ubuntu0.16.04.1_all.deb

    # COMMON LIBS
    # required for php5
    dpkg -i $PACKAGES_PATH/libs/libmysqlclient20_5.7.16-0ubuntu0.16.04.1_amd64.deb
    dpkg -i $PACKAGES_PATH/libs/libxslt1.1_1.1.28-2.1_amd64.deb 
    dpkg -i $PACKAGES_PATH/libs/libssl1.0.2_1.0.2j-1+deb.sury.org~xenial+1_amd64.deb
    
    # required for spamassassin
    dpkg -i $PACKAGES_PATH/libs/libnetaddr-ip-perl_4.078+dfsg-1build1_amd64.deb
    dpkg -i $PACKAGES_PATH/libs/libmail-spf-perl_2.9.0-4_all.deb
    
    # required for clamav
    dpkg -i $PACKAGES_PATH/libs/libllvm3.6v5_1-3.6.2-3ubuntu2_amd64.deb
    dpkg -i $PACKAGES_PATH/libs/libclamav7_0.99.2+dfsg-0ubuntu0.16.04.1_amd64.deb

    # required for libapache5/apache2
    dpkg -i $PACKAGES_PATH/libs/liblua5.1-0_5.1.5-8ubuntu1_amd64.deb 
    dpkg -i $PACKAGES_PATH/libs/libaprutil1-dbd-sqlite3_1.5.4-1build1_amd64.deb
    dpkg -i $PACKAGES_PATH/libs/libaprutil1-ldap_1.5.4-1build1_amd64.deb
    dpkg -i $PACKAGES_PATH/libs/libxslt1.1_1.1.28-2.1_amd64.deb

    # Postfix 
    DEBIAN_FRONTEND=noninteractive dpkg -i $PACKAGES_PATH/postfix/postfix_3.1.0-3_amd64.deb
    dpkg -i $PACKAGES_PATH/postfix/postfix-mysql_3.1.0-3_amd64.deb

    # php5
    dpkg -i $PACKAGES_PATH/php5/php-common_1-45+deb.sury.org~xenial+1_all.deb
    dpkg -i $PACKAGES_PATH/php5/php5.5-common_5.5.38-4+deb.sury.org~xenial+1_amd64.deb
    dpkg -i $PACKAGES_PATH/php5/php5.5-xml_5.5.38-4+deb.sury.org~xenial+1_amd64.deb
    dpkg -i $PACKAGES_PATH/php5/php5.5-readline_5.5.38-4+deb.sury.org~xenial+1_amd64.deb
    dpkg -i $PACKAGES_PATH/php5/php5.5-opcache_5.5.38-4+deb.sury.org~xenial+1_amd64.deb
    dpkg -i $PACKAGES_PATH/php5/php5.5-mysql_5.5.38-4+deb.sury.org~xenial+1_amd64.deb
    dpkg -i $PACKAGES_PATH/php5/php5.5-json_5.5.38-4+deb.sury.org~xenial+1_amd64.deb
    dpkg -i $PACKAGES_PATH/php5/php5.5-cli_5.5.38-4+deb.sury.org~xenial+1_amd64.deb

    # spamassassin
    dpkg -i $PACKAGES_PATH/spamassassin/re2c_0.16-1_amd64.deb
    dpkg -i $PACKAGES_PATH/spamassassin/spamc_3.4.1-3_amd64.deb
    dpkg -i $PACKAGES_PATH/spamassassin/spamassassin_3.4.1-3_all.deb
    dpkg -i $PACKAGES_PATH/spamassassin/sa-compile_3.4.1-3_all.deb 

    # clamav
    dpkg -i $PACKAGES_PATH/clamav/clamav-base_0.99.2+dfsg-0ubuntu0.16.04.1_all.deb
    dpkg -i $PACKAGES_PATH/clamav/clamav-freshclam_0.99.2+dfsg-0ubuntu0.16.04.1_amd64.deb
    dpkg -i $PACKAGES_PATH/clamav/clamav_0.99.2+dfsg-0ubuntu0.16.04.1_amd64.deb

    # dovecot
    dpkg -i $PACKAGES_PATH/dovecot/dovecot-core_1-2.2.22-1ubuntu2.1_amd64.deb
    dpkg -i $PACKAGES_PATH/dovecot/dovecot-imapd_1-2.2.22-1ubuntu2.1_amd64.deb
    dpkg -i $PACKAGES_PATH/dovecot/dovecot-mysql_1-2.2.22-1ubuntu2.1_amd64.deb

    # apache2
    dpkg -i $PACKAGES_PATH/apache2/apache2-utils_2.4.18-2ubuntu3.1_amd64.deb
    dpkg -i $PACKAGES_PATH/apache2/apache2-bin_2.4.18-2ubuntu3.1_amd64.deb
    dpkg -i $PACKAGES_PATH/apache2/apache2-data_2.4.18-2ubuntu3.1_all.deb
    dpkg -i $PACKAGES_PATH/apache2/apache2_2.4.18-2ubuntu3.1_amd64.deb

    # libapache5
    dpkg -i $PACKAGES_PATH/libapache2-mod-php5.5/libapache2-mod-php5.5_5.5.38-4+deb.sury.org~xenial+1_amd64.deb

    # nginx
    dpkg -i $PACKAGES_PATH/nginx/libxpm4_1-3.5.11-1_amd64.deb
    dpkg -i $PACKAGES_PATH/nginx/libwebp5_0.4.4-1+deb.sury.org~xenial+1_amd64.deb
    dpkg -i $PACKAGES_PATH/nginx/libgd3_2.2.3-3+deb.sury.org~xenial+0_amd64.deb
    dpkg -i $PACKAGES_PATH/nginx/nginx-common_1.10.0-0ubuntu0.16.04.4_all.deb
    dpkg -i $PACKAGES_PATH/nginx/nginx-core_1.10.0-0ubuntu0.16.04.4_amd64.deb
    dpkg -i $PACKAGES_PATH/nginx/nginx_1.10.0-0ubuntu0.16.04.4_all.deb

    # mxHero appliance
    dpkg -i $PACKAGES_PATH/mxhero-amd64.deb
}

function purge_dependencies(){
    echo_sub "purging dependencies packages ..."
    # libapache5
    dpkg --purge libapache2-mod-php5.5
    # apache2
    dpkg --purge apache2 apache2-data apache2-bin apache2-utils
    # dovecot
    dpkg --purge dovecot-mysql dovecot-imapd dovecot-core
    # clamav 
    dpkg --purge clamav clamav-freshclam clamav-base
    # spamassassin
    dpkg --purge sa-compile spamassassin spamc re2c
    # php5
    dpkg --purge php5.5-xml php5.5-mysql php5.5-cli php5.5-json \
    php5.5-opcache php5.5-readline php5.5-common php-common
    # Postfix 
    dpkg --purge postfix-mysql postfix
    # MySQL
    dpkg --purge mysql-server mysql-server-5.7 mysql-server-core-5.7 \
    mysql-client-5.7 mysql-client-core-5.7 libmysqlclient20 mysql-common
    # Libs
    dpkg --purge libxslt1.1 libaprutil1-ldap libaprutil1-dbd-sqlite3 liblua5.1-0 \
    libclamav7 libllvm3.6v5 libmail-spf-perl libnetaddr-ip-perl libssl1.0.2
    # nginx
}

function check_packages() {
    dpkg -l mysql-server postfix postfix-mysql dovecot-core dovecot-imapd \
    dovecot-mysql spamassassin clamav apache2 libapache2-mod-php5.5 \
    php5.5-mysql php5.5-xml nginx mxhero
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
}

function create_default_database_users(){
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON attachments.* TO attachmentlink@'localhost' IDENTIFIED BY 'attachmentlink'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON mxhero.* TO mxhero@'localhost' IDENTIFIED BY 'mxhero'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON mxhero.* TO mxhero@'%' IDENTIFIED BY 'mxhero'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON attachments.* TO 'mxhero'@'%'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON statistics.* TO 'mxhero'@'%'"
    /usr/bin/mysql -u root -Bse "GRANT ALL PRIVILEGES ON threadlight.* TO 'mxhero'@'%'"
    /usr/bin/mysql -u root -Bse "FLUSH PRIVILEGES"
}

function create_linux_user(){
    id mxhero >/dev/null 2>/dev/null || \
    adduser --gecos "" --no-create-home --disabled-password --quiet --shell /bin/bash mxhero
}

function install_license(){
    echo "install license"
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

    chown www-data: -R /$ROUNDCUBE_PATH

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

    sed -i 's/#valid_chroot_dirs =/valid_chroot_dirs = \/opt\/maildir-mxhero\/%d/g' $DOVECOT_CONF_PATH/10-mail.conf
    sed -i "s/#first_valid_gid/first_valid_gid=${MXHERO_USER_ID}/g" $DOVECOT_CONF_PATH/10-mail.conf
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

function installation_notes() {
    echo "==============="
    echo "if you wish to install the mxHero zimlet (Zimbra Only)"
    echo "run the command on every mailbox server:"
    echo "wget https://s3-server/zimletao.zip && zmzimletctl deploy /tmp/zimletao.zip"

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
