#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#--------------------------------------------------------------------
#  Script de NiPeGun para instalar y configurar lolMiner en Ubuntu
#
#  Ejecución remota:
#  curl -s x | bash
#--------------------------------------------------------------------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

vArchivo=$(curl -s https://github.com/Lolliedieb/lolMiner-releases/releases/tag/1.48 | grep href | grep "tar.gz" | grep 64 | cut -d'"' -f2)
sudo apt-get -y install wget
wget https://github.com$vArchivo -O /home/nipegun/lolminer.tar.gz
sudo apt-get -y install tar
cd /home/nipegun/

tar -xvf /home/nipegun/lolminer.tar.gz
mv /home/nipegun/1.48 /home/nipegun/lolMiner
