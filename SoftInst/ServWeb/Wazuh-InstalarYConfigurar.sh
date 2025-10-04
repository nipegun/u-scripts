#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar Wazuh en Ubuntu
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/Wazuh-InstalarYConfigurar.sh | bash
#
# Ejecución remota sin caché:
#   curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/Wazuh-InstalarYConfigurar.sh | bash
#
# Ejecución remota con parámetros:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/Wazuh-InstalarYConfigurar.sh | bash -s Parámetro1 Parámetro2
#
# Bajar y editar directamente el archivo en nano
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/Wazuh-InstalarYConfigurar.sh | nano -
# ----------

# Definir constantes de color
  cColorAzul="\033[0;34m"
  cColorAzulClaro="\033[1;34m"
  cColorVerde='\033[1;32m'
  cColorRojo='\033[1;31m'
  # Para el color rojo también:
    #echo "$(tput setaf 1)Mensaje en color rojo. $(tput sgr 0)"
  cFinColor='\033[0m'

# Determinar la versión de Ubuntu
  cVersUbuntu=$(cat /etc/lsb-release | grep ODENAME | head -n1 | cut -d'=' -f2)

if [ $cVersUbuntu == "noble" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Wazuh para Ubuntu 24.04 LTS (Noble Numbat)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 24.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Wazuh para Ubuntu 22.04 LTS (Jammy Jellyfish)...${cFinColor}"
  echo ""

  # Determinar la última versión disppnible
    echo ""
    echo "    Determinando la última versión disponible..."
    echo ""
    vUltVersWazuh=$(curl -sL https://documentation.wazuh.com/current/release-notes/index.html | sed 's->->\n-g' | grep href | grep release | grep internal | head -n1 | sed 's|release-||g' | cut -d'.' -f1 | cut -d'"' -f4 | sed 's|-|.|g')
    echo "      La última versión disponible es la $vUltVersWazuh"
    echo ""

  # Instalar
    vUltVersSanitizada=$(echo "$vUltVersWazuh" | cut -d. -f1-2)
    echo ""
    echo "    Instalando la versión $vUltVersSanitizada..."
    echo ""
    cd /tmp
    rm -f wazuh-install*.sh* 2> /dev/null
    curl -sLO https://packages.wazuh.com/"$vUltVersSanitizada"/wazuh-install.sh
    chmod +x /tmp/wazuh-install.sh
    # Instalar
      # Comprobar si el paquete sudo está instalado. Si no lo está, instalarlo.
        if [[ $(dpkg-query -s sudo 2>/dev/null | grep installed) == "" ]]; then
          echo ""
          echo -e "${cColorRojo}  El paquete sudo no está instalado. Iniciando su instalación...${cFinColor}"
          echo ""
          apt-get -y update
          apt-get -y install sudo
          echo ""
        fi
      sudo /tmp/wazuh-install.sh -a || exit

    # Deshabilitar actualizaciones
      echo ""
      echo "    Deshabilitando actualizaciones..."
      echo ""
      sudo sed -i "s/^deb /#deb /" /etc/apt/sources.list.d/wazuh.list
      sudo apt-get -y update > /dev/null

    # Notificar fin de ejecución del script
      echo ""
      echo "    Ejecución del script, finalizada. Accede al panel de Wazuh en:"
      echo ""
      vIPLocal=$(hostname -I | sed 's- --g')
      echo "      https://$vIPLocal"
      echo ""
      echo "    Si quieres ver las contraseñas de todos los usuarios de Wazuh indexer y Wazuh API puedes hacerlo de la siguiente manera:"
      echo ""
      echo "      sudo tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt"
      echo ""
      echo "    Se ha salvado un backup de los usuarios internos en: /etc/wazuh-indexer/internalusers-backup"
      echo ""
      echo "    Puedes ver la contraseña del usuario admin desplazando la terminal hacia arriba."
      echo ""

elif [ $cVersUbuntu == "focal" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Wazuh para Ubuntu 20.04 LTS (Focal Fossa)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 20.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Wazuh para Ubuntu 18.04 LTS (Bionic Beaver)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 18.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Wazuh para Ubuntu 16.04 LTS (Xenial Xerus)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 16.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "trusty" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Wazuh para Ubuntu 14.04 LTS (Trusty Tahr)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

else

  echo ""
  echo -e "${cColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${cFinColor}"
  echo ""

fi

