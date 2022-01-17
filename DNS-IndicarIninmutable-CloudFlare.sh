#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#-------------------------------------------------------------------------------------------------------
#  Script de NiPeGun para configurar CloudFlare como servidor DNS ininmutable en Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/DNS-IndicarFijo-CloudFlare.sh | bash
#-------------------------------------------------------------------------------------------------------

echo ""
echo "  Configurando CloudFlare como servidor DNS ininmutable..."
echo ""
sudo chattr -i /etc/resolv.conf.bak 2> /dev/null
sudo su root -c "echo 'nameserver 1.1.1.1'  > /etc/resolv.conf.bak"
sudo su root -c "echo 'nameserver 1.0.0.1' >> /etc/resolv.conf.bak"
sudo chattr +i /etc/resolv.conf.bak
sudo rm -f /etc/resolv.conf
sudo cp /etc/resolv.conf.bak /etc/resolv.conf
sudo chattr +i /etc/resolv.conf

