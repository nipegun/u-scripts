#!/bin/bash

echo ""
echo "  Determinando enlace de descarga..."
echo ""
vEnlaceArchivoDeb=$(curl -s https://www.webmin.com/download.html | sed 's->-\n-g' | grep href | grep current | grep deb | cut -d '=' -f2)
  
echo ""
echo "  Descargando archivo deb..."
echo ""
# Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
  echo ""
  echo -e "${vColorRojo}wget no está instalado. Iniciando su instalación...${vFinColor}"
  echo ""
  sudo apt-get -y update && sudo apt-get -y install wget
  echo ""
fi
sudo mkdir -p /root/SoftInst/webmin
sudo wget $vEnlaceArchivoDeb -O /root/SoftInst/webmin/webmin.deb

echo ""
echo "  Instalando dependencias..."
echo ""
sudo apt-get -y update
sudo apt-get -y install libauthen-pam-perl
sudo apt-get -y install libio-pty-perl
sudo apt-get -y install libnet-ssleay-perl
sudo apt-get -y install perl-openssl-defaults

echo ""
echo "  Instalando paquete deb..."
echo ""
sudo dpkg -i /root/SoftInst/webmin/webmin.deb
