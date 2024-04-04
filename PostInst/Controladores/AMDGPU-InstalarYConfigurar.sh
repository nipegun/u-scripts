#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para instalar y configurar los controladres de AMDGPU en Ubuntu
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/main/PostInst/Controladores/AMDGPU-InstalarYConfigurar.sh | bash
#
# Ejecución remota sin caché:
#   curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/nipegun/u-scripts/main/PostInst/Controladores/AMDGPU-InstalarYConfigurar.sh | bash
# ----------

vNomUsuarioNoRoot="$LOGNAME"
vNomUsuarioNoRoot="usuariox"

cVersUbuntu=$(cat /etc/os-release | grep ERSION | grep -v ID | grep -v ODENAME | cut -d'"' -f2 | cut -d' ' -f1)

# Definir constantes de color
  cColorAzul="\033[0;34m"
  cColorAzulClaro="\033[1;34m"
  cColorVerde='\033[1;32m'
  cColorRojo='\033[1;31m'
  # Para el color rojo también:
    #echo "$(tput setaf 1)Mensaje en color rojo. $(tput sgr 0)"
  cFinColor='\033[0m'


if [ $cVersUbuntu == "22.04.4" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de AMDPGU para Ubuntu $cVersUbuntu...${cFinColor}"
  echo ""

  # Obtener la versión
    cUltVers=$(curl -sL https://www.amd.com/es/support/linux-drivers)
  # Determinar que versión descargar
    #vVersArch="http://repo.radeon.com/amdgpu-install/22.20.5/ubuntu/jammy/amdgpu-install_22.20.50205-1_all.deb"
    vVersArch="http://repo.radeon.com/amdgpu-install/23.30.3/ubuntu/jammy/amdgpu-install_5.7.50703-1_all.deb"
    #vVersArch="http://repo.radeon.com/amdgpu-install/23.40.3/ubuntu/jammy/amdgpu-install_6.0.60003-1_all.deb"
  # Descargar el archivo
    # Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
      if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
        echo ""
        echo -e "${vColorRojo}    El paquete wget no está instalado. Iniciando su instalación...${vFinColor}"
        echo ""
        sudo apt-get -y update
        sudo apt-get -y install wget
        echo ""
      fi
    wget $vVersArch -O ~/Descargas/amdgpu-install-repository.deb
    #wget https://drivers.amd.com/drivers/linux/amdgpu-pro-20.40-1147286-ubuntu-20.04.tar.xz --referer https://www.amd.com/es/support/kb/release-notes/rn-amdgpu-unified-linux-20-40
  # Corregir permisos
    sudo chmod 777 ~/Descargas/amdgpu-install-repository.deb
  # Instalar paquete
    sudo apt install ~/Descargas/amdgpu-install-repository.deb
  # Actualizar lista de paquetes de los repositorios
    sudo apt-get update
  # Instalar controlador
    sudo amdgpu-install -y --accept-eula --usecase=opencl --opencl=rocr,legacy
  # Agregar usuario al grupo render
    sudo usermod -a -G render $vNomUsuarioNoRoot
  # Agregar usuario al grupo video
    sudo usermod -a -G video $vNomUsuarioNoRoot
  # Instalar el paquete clinfo
    sudo apt-get -y install clinfo

elif [ $cVersUbuntu == "22.04.5" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de AMDPGU para Ubuntu $cVersUbuntu...${cFinColor}"
  echo ""

  echo ""
  echo -e "${cColorRojo}    Comandos para Ubuntu $cVersUbuntu todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
  echo ""

elif [ $cVerSO == "22.04.6" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de AMDPGU para Ubuntu $cVersUbuntu...${cFinColor}"
  echo ""

  echo ""
  echo -e "${cColorRojo}    Comandos para Ubuntu $cVersUbuntu todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
  echo ""


elif [ $cVersUbuntu == "24.04" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de AMDPGU para Ubuntu $cVersUbuntu...${cFinColor}"
  echo ""

  echo ""
  echo -e "${cColorRojo}    Comandos para Ubuntu $cVersUbuntu todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
  echo ""

elif [ $cVersUbuntu == "24.04.1" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de AMDPGU para Ubuntu $cVersUbuntu...${cFinColor}"
  echo ""

  echo ""
  echo -e "${cColorRojo}    Comandos para Ubuntu $cVersUbuntu todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
  echo ""

elif [ $cVersUbuntu == "24.04.2" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de AMDPGU para Ubuntu $cVersUbuntu...${cFinColor}"
  echo ""

  echo ""
  echo -e "${cColorRojo}    Comandos para Ubuntu $cVersUbuntu todavía no preparados. Prueba ejecutarlo en otra versión de Debian.${cFinColor}"
  echo ""

fi

# Notificar fin de ejecución del script
  echo ""
  echo -e "${cColorVerde}    Ejecución del script, finalizada.${cFinColor}"
  echo -e "${cColorVerde}      Para eliminar los drivers ejecuta:${cFinColor}"
  echo -e "${cColorVerde}        sudo amdgpu-uninstall${cFinColor}"
  echo -e "${cColorVerde}        sudo apt-get -y purge amdgpu-instal${cFinColor}"
  echo ""

