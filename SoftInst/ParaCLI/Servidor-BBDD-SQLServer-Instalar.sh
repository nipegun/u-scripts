#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar xxxxxxxxx en Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/SoftInst/ParaCLI/Servidor-BBDD-SQLServer-Instalar.sh | bash
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
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 14.04 LTS (Trusty Tahr)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $vVersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 16.04 LTS (Xenial Xerus)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 16.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $vVersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 18.04 LTS (Bionic Beaver)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 18.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $vVersUbuntu == "focal" ]; then

  echo ""
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 20.04 LTS (Focal Fossa)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 20.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $vVersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${vColorAzulClaro}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 22.04 LTS (Jammy Jellyfish)...${vFinColor}"
  echo ""

  # Comprobar si el paquete curl está instalado. Si no lo está, instalarlo.
    if [[ $(dpkg-query -s curl 2>/dev/null | grep installed) == "" ]]; then
      echo ""
      echo -e "${vColorRojo}  El paquete curl no está instalado. Iniciando su instalación...${vFinColor}"
      echo ""
      apt-get -y update
      apt-get -y install curl
      echo ""
    fi
  # Agregar el repositorio
    curl -sL https://packages.microsoft.com/config/ubuntu/20.04/mssql-server-2022.list > /etc/apt/sources.list.d/mssql-server-2022.list
  # Agregar la llave
    # Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
      if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
        echo ""
        echo -e "${vColorRojo}  El paquete wget no está instalado. Iniciando su instalación...${vFinColor}"
        echo ""
        apt-get -y update
        apt-get -y install wget
        echo ""
      fi
    # Comprobar si el paquete gnupg2 está instalado. Si no lo está, instalarlo.
      if [[ $(dpkg-query -s gnupg2 2>/dev/null | grep installed) == "" ]]; then
        echo ""
        echo -e "${vColorRojo}  El paquete gnupg2 no está instalado. Iniciando su instalación...${vFinColor}"
        echo ""
        apt-get -y update
        apt-get -y install gnupg2
        echo ""
      fi
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
  # Instalar el paquete
    apt-get -y update
    apt-get -y install mssql-server
  # Configurar
    /opt/mssql/bin/mssql-conf setup
  # Estado del servicio
    systemctl status mssql-server --no-pager
  # Instalar herramientas
    # Agregar repositorio
      curl -sL https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/msprod.list
    # Agregar llave
      curl -sL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
    # Actualizar
      apt-get -y update
    # Instalar paquetes
      apt-get -y install mssql-tools unixodbc-dev
    # Agregar la variable de entorno
      sh -c "echo 'export PATH=$PATH:/opt/mssql-tools/bin/' >> /root/.bash_profile"
      sh -c "echo 'export PATH=$PATH:/opt/mssql-tools/bin/' >> /root/.bashrc"
      source /root/.bashrc
  # Quitar permiso de ejecución al archivo del servicio
    chmod -x /usr/lib/systemd/system/mssql-server.service
  # Notificar de fin de la instalación
    echo ""
    echo "  Instalación finalizada..."
    echo ""
    echo "  Para conectarte a la CLI de SQLServer ejecuta:"
    echo ""
    echo "    sqlcmd -S localhost -U sa -P 'Contraseña'"
    echo "    o"
    echo "    sqlcmd -S localhost -U sa"
    echo ""
    echo "  ...para hacer que pida la contraseña."
    echo ""
    echo "  NOTA: sa (System Administrator) es el root."
    echo ""
    echo "  Para ver el estado del servicio, ejecuta: "
    echo "    systemctl status  mssql-server.service --no-pager"
    #sp_configure @configname = 'remote admin connections', @configvalue = 1;
    #go
    #reconfigure;
    #go

else

  echo ""
  echo -e "${vColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${vFinColor}"
  echo ""

fi

