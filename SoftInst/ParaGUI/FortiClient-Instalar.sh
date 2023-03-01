#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar FortiClient en Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/SoftInst/ParaGUI/FortiClient-Instalar.sh | bash
# ----------

vColorAzul="\033[0;34m"
vColorAzulClaro="\033[1;34m"
vColorVerde='\033[1;32m'
vColorRojo='\033[1;31m'
vFinColor='\033[0m'

# Determinar la versión de Ubuntu
  vVersUbuntu=$(cat /etc/lsb-release | grep ODENAME | head -n1 | cut -d'=' -f2)

if [ $vVersUbuntu == "trusty" ]; then

  echo ""
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de FortiClient para Ubuntu 14.04 LTS (Trusty Tahr)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $vVersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de FortiClient para Ubuntu 16.04 LTS (Xenial Xerus)...${vFinColor}"
  echo ""

  # Agregar la llave
    # Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
      if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
        echo ""
        echo -e "${vColorRojo}  El paquete wget no está instalado. Iniciando su instalación...${vFinColor}"
        echo ""
        sudo apt-get -y update
        sudo apt-get -y install wget
        echo ""
      fi
    wget -O - https://repo.fortinet.com/repo/7.0/ubuntu/DEB-GPG-KEY | sudo apt-key add -
  # Agregar el repositorio
    sudo echo "deb [arch=amd64] https://repo.fortinet.com/repo/7.0/ubuntu xenial multiverse" > /etc/apt/sources.list.d/FortiNet.list
  # Actualizar la lista de paquetes
    sudo apt-get -y update
  # Instalar el paquete
    sudo apt-get -y install forticlient

elif [ $vVersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de FortiClient para Ubuntu 18.04 LTS (Bionic Beaver)...${vFinColor}"
  echo ""

  # Agregar la llave
    # Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
      if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
        echo ""
        echo -e "${vColorRojo}  El paquete wget no está instalado. Iniciando su instalación...${vFinColor}"
        echo ""
        sudo apt-get -y update
        sudo apt-get -y install wget
        echo ""
      fi
    wget -O - https://repo.fortinet.com/repo/7.0/ubuntu/DEB-GPG-KEY | sudo apt-key add -
  # Agregar el repositorio
    sudo echo "deb [arch=amd64] https://repo.fortinet.com/repo/6.4/ubuntu/ /bionic multiverse" > /etc/apt/sources.list.d/FortiNet.list
  # Actualizar la lista de paquetes
    sudo apt-get -y update
  # Instalar el paquete
    sudo apt-get -y install forticlient

elif [ $vVersUbuntu == "focal" ]; then

  echo ""
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de FortiClient para Ubuntu 20.04 LTS (Focal Fossa)...${vFinColor}"
  echo ""

  # Agregar la llave
    # Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
      if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
        echo ""
        echo -e "${vColorRojo}  El paquete wget no está instalado. Iniciando su instalación...${vFinColor}"
        echo ""
        sudo apt-get -y update
        sudo apt-get -y install wget
        echo ""
      fi
    wget -O - https://repo.fortinet.com/repo/7.0/ubuntu/DEB-GPG-KEY | sudo apt-key add -
  # Agregar el repositorio
    sudo echo "deb [arch=amd64] https://repo.fortinet.com/repo/6.4/ubuntu/ /bionic multiverse" > /etc/apt/sources.list.d/FortiNet.list
  # Actualizar la lista de paquetes
    sudo apt-get -y update
  # Instalar el paquete
    sudo apt-get -y install forticlient

elif [ $vVersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de FortiClient para Ubuntu 22.04 LTS (Jammy Jellyfish)...${vFinColor}"
  echo ""
  mkdir -p ~/SoftInst/Fortinet/ 2> /dev/null
  wget https://links.fortinet.com/forticlient/deb/vpnagent -O ~/SoftInst/Fortinet/vpnagent.deb
  chmod 777 ~/SoftInst/Fortinet/vpnagent.deb
  sudo apt -y install ~/SoftInst/Fortinet/vpnagent.deb

  # Desinstalar
    #sudo apt -y autoremove --purge forticlient
else

  echo ""
  echo -e "${vColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${vFinColor}"
  echo ""

fi

