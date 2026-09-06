#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar los controladores Web de nVidia en Ubuntu
#
# Ejecución remota (puede requerir permisos sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Desinstalar.sh | bash
#
# Ejecución remota como root (para sistemas sin sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Desinstalar.sh | sed 's-sudo--g' | bash
#
# Ejecución remota sin caché:
#   curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Desinstalar.sh | bash
#
# Ejecución remota con parámetros:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Desinstalar.sh | bash -s Parámetro1 Parámetro2
#
# Bajar y editar directamente el archivo en nano
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/Controladores/Graficas-NVIDIA-Controladores-DeWeb-Desinstalar.sh | nano -
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

  # Descargar el instalador
    echo ""
    echo "    Descargando el instalador..."
    echo ""
    curl -L https://es.download.nvidia.com/XFree86/Linux-x86_64/"$vNroUltVersEstable"/NVIDIA-Linux-x86_64-"$vNroUltVersEstable".run -o /tmp/nVidiaWebDriverInstall.run
    chmod +x /tmp/nVidiaWebDriverInstall.run

  # Ejecutar el desinstalador
    echo ""
    echo "    Ejecutando el desinstalador..."
    echo ""
    sudo /tmp/nVidiaWebDriverInstall.run --uninstall --silent

  # Borrar directorios extras
    sudo rm -rf /usr/share/egl/egl_external_platform.d/
    sudo rm -rf /usr/lib/x86_64-linux-gnu/nvidia/wine/
    sudo rm -rf /usr/lib/x86_64-linux-gnu/nvidia/
    sudo rm -rf /usr/share/nvidia/
    sudo rm -rf /usr/lib/nvidia/
    sudo rm -rf /usr/share/egl/

  # Notificar fin de ejecución del script
    echo ""
    echo "    Ejecución del script, finalizada. Para aplicar los cambios reinicia el sistema con:"
    echo ""
    echo "      shutdown -r now"
    echo ""

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
