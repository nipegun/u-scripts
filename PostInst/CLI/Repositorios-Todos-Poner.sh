#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para poner los repositorios completos a las diferentes versiones de Ubuntu
#
# Ejecución remota (puede requerir permisos sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/CLI/Repositorios-Todos-Poner.sh | bash
#
# Ejecución remota como root (para sistemas sin sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/CLI/Repositorios-Todos-Poner.sh | sed 's-sudo--g' | bash
#
# Bajar y editar directamente el archivo en nano
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/CLI/Repositorios-Todos-Poner.sh | nano -
# ----------

# Determinar la fecha de ejecución del script
  cFechaDeEjec=$(date +"a%Ym%md%dh%Hm%Ms%S")

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
  echo -e "${cColorAzulClaro}  Iniciando el script para poner todos los repositorios de Ubuntu 24.04 LTS (Noble Numbat)...${cFinColor}"
  echo ""

  # Hacer copia de seguridad del sources.list actual
    sudo cp -vf /etc/apt/sources.list /etc/apt/sources.list.bak-$cFechaDeEjec
  echo ''                                                                                             | sudo tee    /etc/apt/sources.list
  echo '# Repositorios principales'                                                                   | sudo tee -a /etc/apt/sources.list
  echo 'deb http://archive.ubuntu.com/ubuntu noble main restricted universe multiverse'               | sudo tee -a /etc/apt/sources.list
  echo 'deb-src http://archive.ubuntu.com/ubuntu noble main restricted universe multiverse'           | sudo tee -a /etc/apt/sources.list
  echo ''                                                                                             | sudo tee -a /etc/apt/sources.list
  echo '# Actualizaciones oficiales'                                                                  | sudo tee -a /etc/apt/sources.list
  echo 'deb http://archive.ubuntu.com/ubuntu noble-updates main restricted universe multiverse'       | sudo tee -a /etc/apt/sources.list
  echo 'deb-src http://archive.ubuntu.com/ubuntu noble-updates main restricted universe multiverse'   | sudo tee -a /etc/apt/sources.list
  echo ''                                                                                             | sudo tee -a /etc/apt/sources.list
  echo '# Repos de seguridad'                                                                         | sudo tee -a /etc/apt/sources.list
  echo 'deb http://security.ubuntu.com/ubuntu noble-security main restricted universe multiverse'     | sudo tee -a /etc/apt/sources.list
  echo 'deb-src http://security.ubuntu.com/ubuntu noble-security main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list
  echo ''                                                                                             | sudo tee -a /etc/apt/sources.list
  echo '# Backports (paquetes más nuevos mantenidos por la comunidad)'                                | sudo tee -a /etc/apt/sources.list
  echo 'deb http://archive.ubuntu.com/ubuntu noble-backports main restricted universe multiverse'     | sudo tee -a /etc/apt/sources.list
  echo 'deb-src http://archive.ubuntu.com/ubuntu noble-backports main restricted universe multiverse' | sudo tee -a /etc/apt/sources.list
  # Actualizar la lista de paquetes disponibles en los repos
    sudo apt-get -y update

elif [ $cVersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script para poner todos los repositorios de Ubuntu 22.04 LTS (Jammy Jellyfish)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 22.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "focal" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script para poner todos los repositorios de Ubuntu 20.04 LTS (Focal Fossa)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 20.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script para poner todos los repositorios de Ubuntu 18.04 LTS (Bionic Beaver)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 18.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script para poner todos los repositorios de Ubuntu 16.04 LTS (Xenial Xerus)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 16.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "trusty" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script para poner todos los repositorios de Ubuntu 14.04 LTS (Trusty Tahr)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

else

  echo ""
  echo -e "${cColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${cFinColor}"
  echo ""

fi
