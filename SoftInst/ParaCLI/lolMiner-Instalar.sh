#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#--------------------------------------------------------------------
#  Script de NiPeGun para instalar y configurar lolMiner en Ubuntu
#
#  Para minar TON y ETH
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/SoftInst/ParaCLI/lolMiner-Instalar.sh | sudo bash
#--------------------------------------------------------------------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

vArchivo=$(curl -s https://github.com/Lolliedieb/lolMiner-releases/releases/tag/1.48 | grep href | grep "tar.gz" | grep 64 | cut -d'"' -f2)
apt-get -y install wget
apt-get -y install tar

mkdir /Mineros 2 >/dev/null
wget https://github.com$vArchivo -O /Mineros/lolminer.tar.gz
tar -xvf /Mineros/lolminer.tar.gz
mv /Mineros/1.48 /Mineros/lolMiner
sed -i -e 's/WALLET=.*/WALLET=UQBLiO-jvWqwChjFqOsYlGDyZw6G3vYrKOQrgqnVNnTghhRs/' /Mineros/lolMiner/mine_ton.sh

sudo apt-get install xserver-xorg-video-dummy
