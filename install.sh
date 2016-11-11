#!/bin/bash
set -o errexit
set -o pipefail

# TODO: set lock after the installation is finished

# while getopts "l:f:" OPTION; do
#     echo $OPTION $OPTARG
#     case $OPTION in
#     l)
#         LICENSE_FILE=$OPTARG
#         ;;
#     c)
#         CONFIG=$OPTARG
#         ;;
#     *)  
#         echo "Incorrect options provided"
#         exit 1
#         ;;
#     esac
# done

# exit 0;

if [ ! -z $DEBUG ]; then
    echo "debug on!"
    set -x
fi

source utils/functions.sh
export STEPS=10

echo_title "Installing mxHero"
echo_subtitle "step 1/$STEPS - installing packages, this may take a while ..."

# if the required packages are installed, skip the installation process
check_packages > /dev/null || install_packages

check_packages > /dev/null && true

if [ ! $? -eq 0 ]; then
        echo_subtitle "fail: missing a required package"
        echo_subtitle "try running the installation script with the DEBUG flag"
        exit $?
fi

echo_subtitle "step 2/$STEPS - configuring server: time,lang,limits ..."
configure_server_time
configure_environment_lang
configure_security_limits

echo_subtitle "step 3/$STEPS - creating 'mxhero' linux user ..."
create_linux_user

echo_subtitle "step 4/$STEPS - configuring mxHero ..."
configure_mxhero

echo_subtitle "step 5/$STEPS - configuring roundcube/apache2 ..."
configure_roundcube

echo_subtitle "step 6/$STEPS - configuring dovecot ..."
configure_dovecot

echo_subtitle "step 7/$STEPS - configuring postfix ..."
configure_postfix

echo_subtitle "step 8/$STEPS - configuring mysql ..."
configure_mysql
create_databases

echo_subtitle "step 9/$STEPS - creating database users ..."
create_default_database_users

echo_subtitle "step 10/$STEPS - configuring nginx proxy ..."
configure_nginx

echo_title "installation completed!"
echo ""

installation_notes

# TODO: python scripts generate config files from template!
# TODO: bash copy config files to the proper location and restart its services

