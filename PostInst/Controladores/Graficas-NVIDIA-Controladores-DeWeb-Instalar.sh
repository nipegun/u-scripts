#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar los controladores Web de nVidia en Ubuntu
#
# Ejecución remota (puede requerir permisos sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Instalar.sh | bash
#
# Ejecución remota como root (para sistemas sin sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Instalar.sh | sed 's-sudo--g' | bash
#
# Ejecución remota sin caché:
#   curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Instalar.sh | bash
#
# Ejecución remota con parámetros:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Instalar.sh | bash -s Parámetro1 Parámetro2
#
# Bajar y editar directamente el archivo en nano
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Instalar.sh | nano -
# ----------

# Determinar la última versión estable
  # Comprobar si el paquete curl está instalado. Si no lo está, instalarlo.
    if [[ $(dpkg-query -s curl 2>/dev/null | grep installed) == "" ]]; then
      echo ""
      echo -e "${cColorRojo}  El paquete curl no está instalado. Iniciando su instalación...${cFinColor}"
      echo ""
      sudo apt-get -y update
      sudo apt-get -y install curl
      echo ""
    fi
  vNroUltVersEstable=$(curl -fsSL 'https://www.nvidia.com/es-es/drivers/unix/' | grep -m2 'Linux x86_64/AMD64/EM64T' | grep roducc | grep -oP '<span class="PB">.*?<a[^>]*>\K[0-9]+(\.[0-9]+)+')

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

if [ $cVersUbuntu == "resolut" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de los controladores web de nVidia para Ubuntu 26.04 LTS (Noble Numbat)...${cFinColor}"
  echo ""

  # Instalar paquetes para compilar
    echo ""
    echo "    Instalando paquetes para compilar..."
    echo ""
    sudo apt-get -y update
    sudo apt-get -y install build-essential
    sudo apt-get -y install linux-headers-$(uname -r)
    sudo apt-get -y install dkms
    sudo apt-get -y install pkg-config
    sudo apt-get -y install libglvnd-dev
    sudo apt-get -y install initramfs-tools

  # Blacklistear nouveau
    echo ""
    echo "    Blacklistear nouveau..."
    echo ""
    echo "blacklist nouveau"         | sudo tee    /etc/modprobe.d/blacklist-nouveau.conf
    echo "options nouveau modeset=0" | sudo tee -a /etc/modprobe.d/blacklist-nouveau.conf
    sudo update-initramfs -u -k all

 # Descargar el instalador
    echo ""
    echo "    Descargando el instalador..."
    echo ""
    curl -L https://es.download.nvidia.com/XFree86/Linux-x86_64/"$vNroUltVersEstable"/NVIDIA-Linux-x86_64-"$vNroUltVersEstable".run -o /tmp/nVidiaWebDriverInstall.run
    chmod +x /tmp/nVidiaWebDriverInstall.run

  # Parar entorno gráfico
    echo ""
    echo "    Parando entorno gráfico..."
    echo ""
    sudo systemctl stop gdm
    sudo systemctl stop sddm
    sudo systemctl stop lightdm

 # Ejecutar el instalador
    echo ""
    echo "    Ejecutando el instalador..."
    echo ""
    # Crear el menú
      # Comprobar si el paquete dialog está instalado. Si no lo está, instalarlo.
        if [[ $(dpkg-query -s dialog 2>/dev/null | grep installed) == "" ]]; then
          echo ""
          echo -e "${cColorRojo}  El paquete dialog no está instalado. Iniciando su instalación...${cFinColor}"
          echo ""
          sudo apt-get -y update
          sudo apt-get -y install dialog
          echo ""
        fi
      menu=(dialog --radiolist "Marca las opciones que quieras instalar:" 22 90 16)
        opciones=(
          1 "Propietario           (Obligatorio para GPUs Maxwell, Pascal y Volta antiguas, opcional para tarjetas nuevas)" off
          2 "Abierto, Dual MIT/GPL (Sólo funciona con GPUs Touring y superiores: RTX 20xx en adelante)"                     off
        )
      choices=$("${menu[@]}" "${opciones[@]}" 2>&1 >/dev/tty)
      #clear

      for choice in $choices
        do
          case $choice in

            1)

              echo ""
              echo "  Instalando el driver propietario..."
              echo ""
              sudo sh /tmp/nVidiaWebDriverInstall.run --ui=none --no-questions --accept-license --disable-nouveau --rebuild-initramfs --dkms --no-install-compat32-libs --kernel-module-type=proprietary

            ;;

            2)

              echo ""
              echo "  Instalando el driver Abierto, Dual MIT/GPL..."
              echo ""
              sudo sh /tmp/nVidiaWebDriverInstall.run --ui=none --no-questions --accept-license --disable-nouveau --rebuild-initramfs --dkms --no-install-compat32-libs --kernel-module-type=open

            ;;

        esac

    done

  # Comprobar la gráfica
    nvidia-smi

  # Instalar CUDA Toolkit
    #curl -sL https://raw.githubusercontent.com/nipegun/d-scripts/refs/heads/master/PostInst/Controladores/Graficas-NVIDIA-Controladores-CUDAToolkit-DeWeb-Instalar.sh | sudo bash

elif [ $cVersUbuntu == "noble" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 24.04 LTS (Noble Numbat)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 24.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 22.04 LTS (Jammy Jellyfish)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 22.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "focal" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 20.04 LTS (Focal Fossa)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 20.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 18.04 LTS (Bionic Beaver)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 18.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 16.04 LTS (Xenial Xerus)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 16.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "trusty" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 14.04 LTS (Trusty Tahr)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

else

  echo ""
  echo -e "${cColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${cFinColor}"
  echo ""

fi
