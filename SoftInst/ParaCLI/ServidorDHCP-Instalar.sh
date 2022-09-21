#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para preparar un Debian recién instalado para que actúe como router por eth1
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/r-scripts/master/PostInst/RoutearPor-eth1.sh | bash
#  curl -s https://raw.githubusercontent.com/nipegun/r-scripts/master/PostInst/RoutearPor-eth1.sh | sed 's-vLANIP="192.168.1"-vLANIP="192.168.90"-g' | bash
# ----------

vIntEth0="eth0"
vIntEth1="eth1"
vLANIP="192.168.1"

echo ""
echo "    Instalando isc-dhcp-server..."
echo ""
apt-get -y install isc-dhcp-server
  
echo ""
echo "    Indicando la ubicación del archivo de configuración del demonio dhcpd"
echo "    y la interfaz sobre la que correrá..."
echo ""
cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.bak
echo 'DHCPDv4_CONF=/etc/dhcp/dhcpd.conf'  > /etc/default/isc-dhcp-server
echo 'INTERFACESv4="$vIntEth1"'          >> /etc/default/isc-dhcp-server
echo 'INTERFACESv6=""'                   >> /etc/default/isc-dhcp-server

echo ""
echo "    Configurando dhcp..."
echo ""
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.bak
echo "authoritative;"                                  > /etc/dhcp/dhcpd.conf
echo "subnet $vLANIP.0 netmask 255.255.255.0 {"       >> /etc/dhcp/dhcpd.conf
echo "  range $vLANIP.100 $vLANIP.199;"               >> /etc/dhcp/dhcpd.conf
echo "  option routers $vLANIP.1;"                    >> /etc/dhcp/dhcpd.conf
echo "  option domain-name-servers 1.1.1.1, 1.0.0.1;" >> /etc/dhcp/dhcpd.conf
echo "  default-lease-time 600;"                      >> /etc/dhcp/dhcpd.conf
echo "  max-lease-time 7200;"                         >> /etc/dhcp/dhcpd.conf
echo ""                                               >> /etc/dhcp/dhcpd.conf
echo "  host PrimeraReserva {"                        >> /etc/dhcp/dhcpd.conf
echo "    hardware ethernet 00:00:00:00:00:01;"       >> /etc/dhcp/dhcpd.conf
echo "    fixed-address $vLANIP.10;"                  >> /etc/dhcp/dhcpd.conf
echo "  }"                                            >> /etc/dhcp/dhcpd.conf
echo "}"                                              >> /etc/dhcp/dhcpd.conf
