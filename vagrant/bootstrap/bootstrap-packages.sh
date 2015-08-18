#!/usr/bin/env bash

set -e
export PATH=$PATH:/sbin

function install_packages_centos() {
    release=`uname -r | awk -F. '{ print $4 }'`
    yum -y install https://repo.twindb.com/twindb-release-latest.noarch.rpm

    case ${release} in
        "el5")
            wget -O /tmp/mysql-community-release-el5-5.noarch.rpm --no-check-certificate \
                https://dev.mysql.com/get/mysql-community-release-el5-5.noarch.rpm
            rpm -Uhv /tmp/mysql-community-release-el5-5.noarch.rpm
            rpm -Uvh http://mirror.redsox.cc/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
            ;;
        "el6")
            yum -y install https://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
            rpm -Uvh http://mirror.redsox.cc/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
            ;;
        "el7")
            yum -y install https://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
            rpm -Uvh http://mirror.redsox.cc/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
            ;;
    esac

    packages="
    mysql-community-server
    mysql-connector-python
    percona-xtrabackup
    haveged
    lsof
    redhat-lsb-core
    vim
    rpm-build
    chkconfig"

    yum -y install ${packages}

    chkconfig mysqld on

    case ${release} in
        "el5")
            ;;
        "el6")
            chkconfig haveged on
            /etc/init.d/haveged start
            ;;
        "el7")
            chkconfig haveged on
            service haveged start
            ;;
    esac
}

function install_packages_debian() {
    echo "Installing Debian packages"
}


dist_id=`lsb_release -is`
case "${dist_id}" in
    "CentOS")
        install_packages_centos
        ;;
    "Ubuntu")
        install_packages_debian
        ;;
    "Debian")
        install_packages_debian
        ;;
    *)
        echo "Unknown OS type ${dist_id}"
        lsb_release -a
        exit -1
esac


