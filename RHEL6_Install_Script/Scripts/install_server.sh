#!/bin/bash

## NFS ##

# installs packages if not already installed
cd ../Packages;
cd NFS;
rpm -iv *.rpm;

# edit /etc/exports to add computers
cd /etc/;
rm exports; # for testing only
touch exports; # for testing only
echo "/home    *(rw)" >> exports;
chkconfig nfs on;
chkconfig nfslock on;