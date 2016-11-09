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

# TODO: Execute script to prompt for installation configuration
# Generates a yaml file!

# TODO: dovecot ubuntu packing - OK
# TODO: mxhero ubuntu packing - OK
# TODO: configure system to mxhero package - OK
# TODO: change perms and create mxhero symlinks and quarantine folder - OK
# TODO: logrotate and cron to mxhero install package!  - OK


# TODO: disable update to mxhero installed packages!

# https://ubuntuforums.org/showthread.php?t=910717
# http://packaging.ubuntu.com/html/getting-set-up.html

if [ ! -z $DEBUG ]; then
    echo "debug on!"
    set -x
fi

source utils/functions.sh
STEPS=10

echo_title "Installing mxHero"
echo_subtitle "step 1/$STEPS - installing packages, this may take a while ..."

# if the required packages are installed, skip the installation process
check_packages > /dev/null || \
install_packages > /dev/null 2>&1

check_packages > /dev/null && true

if [ ! $? -eq 0 ]; then
        echo_subtitle "fail: missing a required package"
        echo_subtitle "try running the installation script with the DEBUG flag"
        exit $?
fi

echo_subtitle "step 2/$STEPS - configuring server time ..."
configure_server_time

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

echo_subtitle "step 8/$STEPS - creating databases ..."
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

