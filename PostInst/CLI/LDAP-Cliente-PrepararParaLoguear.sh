#!/bin/bash

echo ""
echo "  Preparando el cliente Ubuntu para poder loguearse en el servidor LDAP..."
echo ""

vBase="BASE dc=practica,dc=com"
vURI="URI ldap://192.168.50.10"

#sudo apt-get update
sudo apt-get -y install ldap-utils    > /dev/null
sudo apt-get -y install libpam-ldap  >> /dev/null
sudo apt-get -y install libnss-ldap  >> /dev/null
sudo apt-get -y install nss-updatedb >> /dev/null
sudo apt-get -y install libnss-db    >> /dev/null
sudo apt-get -y install nscd         >> /dev/null

sudo sed -i -e 's|#bind_policy hard|bind_policy soft|g'  /etc/ldap.conf
sudo sed -i -e 's|pam_password md5|pam_password crypt|g' /etc/ldap.conf

echo "$vBase"       > ~/ldap.conf
echo "$vURI"       >> ~/ldap.conf
echo "SIZELIMIT 0" >> ~/ldap.conf
echo "TIMELIMIT 0" >> ~/ldap.conf
echo "DEREF never" >> ~/ldap.conf
sudo rm -f /etc/ldap/ldap.conf
sudo mv ~/ldap.conf /etc/ldap/ldap.conf
sudo chown root:root /etc/ldap/ldap.conf

sudo sed -i -e 's|systemd|ldap|g' /etc/nsswitch.conf
sudo sed -i -e 's|^passwd:.*|passwd: files ldap|g' /etc/nsswitch.conf
sudo sed -i -e 's|^group:.*|group: files ldap|g'   /etc/nsswitch.conf
sudo sed -i -e 's|^shadow:.*|shadow: files ldap|g' /etc/nsswitch.conf

sudo nss_updatedb ldap

sudo systemctl restart nscd.service

sudo sed -i -e 's|pam_ldap.so use_authtok try_first_pass|pam_ldap.so|g' /etc/pam.d/common-password

