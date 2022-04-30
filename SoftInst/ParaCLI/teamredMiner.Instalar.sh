#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar teamredMiner en Ubuntu
#
#  Para minar TON y ETH
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/SoftInst/ParaCLI/teamredMiner-Instalar.sh | sudo bash
# ----------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

vUltTag=$(curl -s https://github.com/todxx/teamredminer/releases/latest | cut -d'"' -f2)
vArchivo=$(curl -s $vUltTag | grep href | grep inux | cut -d'"' -f2)
apt-get -y install wget
apt-get -y install tar

mkdir /Mineros 2 >/dev/null
wget https://github.com$vArchivo -O /Mineros/teamredMiner.tar.gz
tar -xvf /Mineros/teamredMiner.tar.gz
mv /Mineros/teamredminer-v$Version-linux /Mineros/teamredMiner

echo '#!/bin/bash' > /Mineros/teamredMiner/mine_rvn-woolypooly.sh
echo "/Mineros/teamredMiner/teamredminer -a kawpow -o stratum+tcp://pool.eu.woolypooly.com:55555 -u RKxPhh36Cz6JoqMuq1nwMuPYnkj8DmUswy.YestonRX560-4GB -p x" >> /Mineros/teamredMiner/mine_rvn-woolypooly.sh
chmod 777 /Mineros/teamredMiner/mine_rvn-woolypooly.sh

echo '#!/bin/bash' > /Mineros/teamredMiner/mine_rvn-ravenminer.sh
echo "/Mineros/teamredMiner/teamredminer -a kawpow -o stratum+tcp://eu.ravenminer.com:3838 -u RKxPhh36Cz6JoqMuq1nwMuPYnkj8DmUswy.YestonRX560-4GB -p x" >> /Mineros/teamredMiner/mine_rvn-ravenminer.sh
chmod 777 /Mineros/teamredMiner/mine_rvn-ravenminer.sh

