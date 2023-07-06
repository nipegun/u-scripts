#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para instalar y configurar NBMiner en Ubuntu para minar RVN
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/main/SoftInst/ParaCLI/nbMiner-Instalar.sh | sudo bash
# ----------

# Descargar archivos
  #vUltTag=$(curl -sL https://github.com/NebuTech/NBMiner/releases/latest  | cut -d'"' -f2)
  #vArchivo=$(curl -sL $vUltTag | grep href | grep inux | grep -v "sha" | cut -d'"' -f2)
  vURLArchivoUltVers=$(curl -sL https://nbminer.com | grep "dl.nbminer" | grep inux | head -n1 | cut -d'"' -f2)
  sudo apt-get -y install wget
  sudo mkdir -p /Mineros/ 2 >/dev/null
  sudo wget $vURLArchivoUltVers -O /Mineros/nbMiner.tar.gz

# Descomprimir archivos
  sudo apt-get -y install tar
  sudo tar -xvf /Mineros/nbMiner.tar.gz -C /Mineros/
  sudo mv /Mineros/NBMiner_Linux /Mineros/NBMiner

# Crear los scripts para minar
  sudo echo '#!/bin/bash'                                                                                                                                  > /Mineros/NBMiner/mine_rvn-woolypooly.sh
  sudo echo "/Mineros/NBMiner/nbminer -a kawpow -o stratum+tcp://pool.eu.woolypooly.com:55555 -u RKxPhh36Cz6JoqMuq1nwMuPYnkj8DmUswy.YestonRX560-4GB -p x" >> /Mineros/NBMiner/mine_rvn-woolypooly.sh
  sudo echo '#!/bin/bash'                                                                                                                                 > /Mineros/NBMiner/mine_rvn-ravenminer.sh
  sudo echo "/Mineros/NBMiner/nbminer -a kawpow -o stratum+tcp://stratum.ravenminer.com:3838 -u RKxPhh36Cz6JoqMuq1nwMuPYnkj8DmUswy.YestonRX560-4GB -p x" >> /Mineros/NBMiner/mine_rvn-ravenminer.sh

# Asignar permisos
  sudo chmod 777 /Mineros/NBMiner/ -Rv
