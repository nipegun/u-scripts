#!/bin/bash

sudo sed -i -e 's|#bind_policy hard|bind_policy soft|g' /etc/ldap.conf
sudo sed -i -e 's|pam_password md5|pam_password crypt|g' /etc/ldap.conf
echo "BASE dc=practica,dc=com" > ~/ldap.conf
echo "URI ldap://192.168.50.10" >> ~/ldap.conf
echo "SIZELIMIT 0" >> ~/ldap.conf
echo "TIMELIMIT 0" >> ~/ldap.conf
echo "DEREF never" >> ~/ldap.conf
sudo rm -f /etc/ldap/ldap.conf
sudo mv ~/ldap.conf /etc/ldap/ldap.conf
sudo chown root:root /etc/ldap/ldap.conf
