#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#----------------------------------------------------------------------------------------------------------
#  Script de NiPeGun para configurar Google USA como servidor DNS ininmutable en Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/DNS-IndicarIninmutable-Google.sh | bash
#----------------------------------------------------------------------------------------------------------

echo ""
echo "  Configurando Google USA como servidor DNS ininmutable..."
echo ""

echo ""
echo "    Creando el archivo resolv.conf temporal..."
echo ""
sudo chattr -i /etc/resolv.conf.temp 2> /dev/null
sudo rm -f /etc/resolv.conf.temp     2> /dev/null
sudo su root -c "echo 'nameserver 8.8.8.8'  > /etc/resolv.conf.temp"
sudo su root -c "echo 'nameserver 8.8.4.4' >> /etc/resolv.conf.temp"
sudo chattr +i /etc/resolv.conf.temp

echo ""
echo "    Quitando atributo ininmutable a /etc/resolv.conf..."
echo ""
sudo chattr -i /etc/resolv.conf.temp

echo ""
echo "    Borrando el archivo /etc/resolv.conf..."
echo ""
sudo rm -f /etc/resolv.conf

echo ""
echo "    Copiando el archivo resolv.conf temporal a su ubicación final..."
echo ""
sudo cp /etc/resolv.conf.temp /etc/resolv.conf

echo ""
echo "    Asignando atributo ininmutable a /etc/resolv.conf..."
echo ""
sudo chattr +i /etc/resolv.conf


