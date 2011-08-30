#!/bin/bash

# An install script for RHEL6 security packages and network tools
# By Allison Nelson
# Summer 2011

## NFS ##

# installs packages if not already installed
cd ../Packages;
cd NFS;
rpm -iv *.rpm;

# set up static ports for nfs to allow in the firewall
if [ ! -e "/etc/sysconfig/nfs" ]; then
    touch /etc/sysconfig/nfs;
    echo "MOUNTD_PORT=892" >> /etc/sysconfig/nfs;
    echo "STATD_PORT=662" >> /etc/sysconfig/nfs;
    echo "LOCKD_TCPPORT=32803" >> /etc/sysconfig/nfs;
    echo "LOCKD_UDPPORT=32769" >> /etc/sysconfig/nfs;
else
    # backup old nfs file
    if [ ! -e "/etc/sysconfig/nfs.orig" ]; then
	mv /etc/sysconfig/nfs /etc/sysconfig/nfs.orig;
    fi
    touch /etc/sysconfig/nfs;
    echo "MOUNTD_PORT=892" >> /etc/sysconfig/nfs;
    echo "STATD_PORT=662" >> /etc/sysconfig/nfs;
    echo "LOCKD_TCPPORT=32803" >> /etc/sysconfig/nfs;
    echo "LOCKD_UDPPORT=32769" >> /etc/sysconfig/nfs;
fi

# disable selinux
mv /etc/sysconfig/selinux /etc/sysconfig/selinux.old;

# changes 'enforcing' to 'disabled' under selinux
cat /etc/sysconfig/selinux.old | sed 's/enforcing/disabled/' >> /etc/sysconfig/selinux;
rm /etc/sysconfig/selinux.old;

# disable GUI firewall
mv /etc/sysconfig/system-config-firewall /etc/sysconfig/system-config-firewall.old;
cat /etc/sysconfig/system-config-firewall.old | sed 's/enabled/disabled/' >> /etc/sysconfig/system-config-firewall;
rm /etc/sysconfig/system-config-firewall.old;

# set up iptables rules (removing extra stuff because of the gui firewall and selinux)
