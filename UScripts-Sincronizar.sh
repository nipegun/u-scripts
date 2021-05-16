#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#----------------------------------------------------
#  Script de NiPeGun para sincronizar los u-scripts
#----------------------------------------------------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

# Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo "wget no está instalado. Iniciando su instalación..."
    echo ""
    sudo apt-get -y update
    sudo apt-get -y install wget
fi

# Comprobar si hay conexión a Internet antes de sincronizar los d-scripts
wget -q --tries=10 --timeout=20 --spider https://github.com
  if [[ $? -eq 0 ]]; then
    echo ""
    echo "---------------------------------------------------------"
    echo -e "  ${ColorVerde}Sincronizando los u-scripts con las últimas versiones${FinColor}"
    echo -e "  ${ColorVerde} y descargando nuevos u-scripts si es que existen...${FinColor}"
    echo "---------------------------------------------------------"
    echo ""
    rm ~/scripts/u-scripts -R 2> /dev/null
    mkdir ~/scripts 2> /dev/null
    cd ~/scripts
    git clone --depth=1 https://github.com/nipegun/u-scripts
    mkdir -p ~/scripts/u-scripts/Alias/
    rm ~/scripts/u-scripts/.git -Rf 2> /dev/null
    find ~/scripts/u-scripts/ -type f -iname "*.sh" -exec chmod +x {} \;
    ~/scripts/u-scripts/UScripts-CrearAlias.sh
    find ~/scripts/u-scripts/Alias -type f -exec chmod +x {} \;
    
    echo ""
    echo "-----------------------------------------"
    echo -e "  ${ColorVerde}u-scripts sincronizados correctamente${FinColor}"
    echo "-----------------------------------------"
    echo ""
  else
    echo ""
    echo "---------------------------------------------------------------------------------------------------"
    echo -e "${ColorRojo}No se pudo iniciar la sincronización de los u-scripts porque no se detectó conexión a Internet.${FinColor}"
    echo "---------------------------------------------------------------------------------------------------"
    echo ""
  fi

