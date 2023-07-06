#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar nbMiner en Ubuntu
#
#  Para minar RVN
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/SoftInst/ParaCLI/nbMiner-Instalar.sh | sudo bash
# ----------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

#vUltTag=$(curl -sL https://github.com/NebuTech/NBMiner/releases/latest  | cut -d'"' -f2)
#vArchivo=$(curl -sL $vUltTag | grep href | grep inux | grep -v "sha" | cut -d'"' -f2)
vURLArchivoUltVers=$(curl -sL https://nbminer.com | grep "dl.nbminer" | grep inux | head -n1 | cut -d'"' -f2)
apt-get -y install wget
mkdir /Mineros 2 >/dev/null
wget $vURLArchivoUltVers -O /Mineros/nbMiner.tar.gz
apt-get -y install tar
cd /Mineros
tar -xvf /Mineros/nbMiner.tar.gz

mv /Mineros/nbminer-v$Version-linux /Mineros/nbMiner

echo '#!/bin/bash' > /Mineros/nbMiner/mine_rvn-woolypooly.sh
echo "/Mineros/nbMiner/nbminer -a kawpow -o stratum+tcp://pool.eu.woolypooly.com:55555 -u RKxPhh36Cz6JoqMuq1nwMuPYnkj8DmUswy.YestonRX560-4GB -p x" >> /Mineros/nbMiner/mine_rvn-woolypooly.sh
chmod 777 /Mineros/nbMiner/mine_rvn-woolypooly.sh

echo '#!/bin/bash' > /Mineros/nbMiner/mine_rvn-ravenminer.sh
echo "/Mineros/nbMiner/nbminer -a kawpow -o stratum+tcp://eu.ravenminer.com:3838 -u RKxPhh36Cz6JoqMuq1nwMuPYnkj8DmUswy.YestonRX560-4GB -p x" >> /Mineros/nbMiner/mine_rvn-ravenminer.sh
chmod 777 /Mineros/nbMiner/mine_rvn-ravenminer.sh

