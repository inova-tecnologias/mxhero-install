#!/bin/bash
set -o errexit
set -o pipefail

source utils/functions.sh

while getopts "u:l:s:vh" OPTION; do
    case $OPTION in
    l)
        LICENSE=$OPTARG
        ;;
    s)
        if [ $OPTARG == "FORCE_INSTALL" ]; then
            FORCE_INSTALL=1
        fi
        ;;
    v)
        DEBUG=1
        ;;
    u)
        UNINSTALL=1
        ;;
    h)
        usage
        ;;
    *)
        echo "Incorrect options provided"
        usage
        exit 1
        ;;
    esac
done

if [ ! -z $DEBUG ]; then
    echo "debug on!"
    set -x
fi

# Uninstall packages and mxhero
if [ ! -z $UNINSTALL ]; then
    uninstall
    exit 0
fi

export STEPS=10

if [ -z $FORCE_INSTALL ]; then
    # Check if any ports are listening or if a package is already installed
    mxhero_prerequisites
fi

echo_title "Installing mxHero"
echo_subtitle "step 1/$STEPS - installing packages, this may take a while ..."

install_packages

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

