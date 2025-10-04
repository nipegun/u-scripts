#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar Flectra en Ubuntu
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/Flectra-InstalarYConfigurar.sh | bash
#
# Ejecución remota sin caché:
#   curl -sL -H 'Cache-Control: no-cache, no-store' https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/Flectra-InstalarYConfigurar.sh | bash
#
# Ejecución remota con parámetros:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/Flectra-InstalarYConfigurar.sh | bash -s Parámetro1 Parámetro2
#
# Bajar y editar directamente el archivo en nano
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/Flectra-InstalarYConfigurar.sh | nano -
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
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Flectra para Ubuntu 24.04 LTS (Noble Numbat)...${cFinColor}"
  echo ""

  echo ""
  echo "    Instalando Flectra clonando el repo oficial de gitlab..."
  echo ""

  # Descargar paquetes necesarios para la correcta ejecución del script
    echo ""
    echo "      Descargando paquetes necesarios para la correcta ejecución del script..."
    echo ""
    sudo apt-get -y update
    sudo apt-get -y dist-upgrade
    sudo apt-get -y autoremove
    sudo apt-get -y autoclean

    sudo apt-get -y install curl
    sudo apt-get -y install gpg
    sudo apt-get -y install wget
    sudo apt-get -y install gsfonts
    sudo apt-get -y install fonts-freefont-ttf
    sudo apt-get -y install fonts-dejavu
    sudo apt-get -y install postgresql
    sudo apt-get -y install postgresql-server-dev-all
    sudo apt-get -y install build-essential
    sudo apt-get -y install python3-dev
    sudo apt-get -y install python3-pip
    sudo apt-get -y install python3-venv
    sudo apt-get -y install npm
    sudo apt-get -y install nodejs
    sudo apt-get -y install git
    sudo apt-get -y install libldap2-dev
    sudo apt-get -y install libxml2-dev
    sudo apt-get -y install libxslt1-dev
    sudo apt-get -y install libjpeg-dev
    sudo apt-get -y install unzip
    sudo apt-get -y install libsasl2-dev
    sudo apt-get -y install libldap2-dev
    sudo apt-get -y install libssl-dev

  # Crear el usuario
    echo ""
    echo "      Creando el usuario del sistema..."
    echo ""
    sudo adduser --system --group --home /opt/flectra flectra
    sudo su - postgres -c "createuser -s flectra"

  # Asignar bash como terminal del usuario del sistema
    echo ""
    echo "      Asignando bash como terminal del usuario de sistema..."
    echo ""
    sudo usermod -s /bin/bash flectra
    #sudo getent passwd flectra

  # Determinar la última versión disponible de Flectra
    echo ""
    echo "      Determinando la última versión disponible..."
    echo ""
    vUltVersFlectra=$(curl -ksL download.flectrahq.com | sed 's->->\n-g' | grep href | grep deb | head -n1 | cut -d '"' -f2 | cut -d '/' -f2)
    vCanalUltVers=$(curl -ksL download.flectrahq.com | sed 's->->\n-g' | grep href | grep deb | head -n1 | cut -d '"' -f2 | cut -d '/' -f3)
    echo "      La última versión disponible es la $vUltVersFlectra del canal $vCanalUltVers"
    echo ""

  # Clonar el repo
    echo ""
    echo "      Clonando el repo..."
    echo ""
    sudo rm -rf /opt/flectra/Code/
    sudo su -s /bin/bash -c "\
      cd /opt/flectra/                                                                        && \
      git clone --depth=1 --branch=$vUltVersFlectra https://gitlab.com/flectra-hq/flectra.git && \
      mv /opt/flectra/flectra /opt/flectra/Code
    " flectra

  # Crear el entorno virtual
    echo ""
    echo "      Creando el entorno virtual..."
    echo ""
    sudo rm -rf /opt/flectra/venv/
    sudo su -s /bin/bash -c '\
      mkdir /opt/flectra/venv/                            && \
      python3 -m venv /opt/flectra/venv/                  && \
      source /opt/flectra/venv/bin/activate               && \
      pip install cython                                  && \
      pip install wheel                                   && \
      pip install -r /opt/flectra/Code/requirements.txt   && \
      deactivate \
    ' flectra

  # Crear el archivo de configuración
    echo ""
    echo "      Creando el archivo de configuración..."
    echo ""
    echo '[options]'                              | sudo tee    /opt/flectra/flectra.conf
    echo 'admin_passwd = admin'                   | sudo tee -a /opt/flectra/flectra.conf
    echo 'db_host = False'                        | sudo tee -a /opt/flectra/flectra.conf
    echo 'db_port = False'                        | sudo tee -a /opt/flectra/flectra.conf
    echo 'db_user = flectra'                      | sudo tee -a /opt/flectra/flectra.conf
    echo 'db_password = False'                    | sudo tee -a /opt/flectra/flectra.conf
    echo 'addons_path = /opt/flectra/Code/addons' | sudo tee -a /opt/flectra/flectra.conf
    echo 'default_productivity_apps = True'       | sudo tee -a /opt/flectra/flectra.conf
    echo 'logfile = /var/log/flectra/flectra.log' | sudo tee -a /opt/flectra/flectra.conf
    sudo chown flectra:flectra /opt/flectra/flectra.conf

  # Crear las carpetas para los logs
    echo ""
    echo "      Creando las carpetas para los logs..."
    echo ""
    sudo mkdir -p /var/log/flectra/
    sudo chown flectra:flectra /var/log/flectra/

  # Crear el lanzador
    echo ""
    echo "      Creando el lanzador..."
    echo ""
    echo '#!/opt/flectra/venv/bin/python3'                             | sudo tee    /opt/flectra/flectra-start.py
    echo ''                                                            | sudo tee -a /opt/flectra/flectra-start.py
    echo 'import sys'                                                  | sudo tee -a /opt/flectra/flectra-start.py
    echo 'import os'                                                   | sudo tee -a /opt/flectra/flectra-start.py
    echo ''                                                            | sudo tee -a /opt/flectra/flectra-start.py
    echo '# Agrega el paquete flectra al path'                         | sudo tee -a /opt/flectra/flectra-start.py
    echo 'sys.path.insert(0, "/opt/flectra/Code")'                     | sudo tee -a /opt/flectra/flectra-start.py
    echo ''                                                            | sudo tee -a /opt/flectra/flectra-start.py
    echo 'import flectra'                                              | sudo tee -a /opt/flectra/flectra-start.py
    echo ''                                                            | sudo tee -a /opt/flectra/flectra-start.py
    echo 'if __name__ == "__main__":'                                  | sudo tee -a /opt/flectra/flectra-start.py
    echo '  # Simula sys.argv como si ejecutaras desde consola'        | sudo tee -a /opt/flectra/flectra-start.py
    echo '  sys.argv = ["flectra", "-c", "/opt/flectra/flectra.conf"]' | sudo tee -a /opt/flectra/flectra-start.py
    echo '  flectra.cli.main()'                                        | sudo tee -a /opt/flectra/flectra-start.py
    sudo chmod +x /opt/flectra/flectra-start.py
    sudo chown flectra:flectra /opt/flectra/flectra-start.py

  # Ejecutar Flectra por primera vez
    #echo ""
    #echo "      Ejecutando Flectra por primera vez..."
    #echo ""
    #sudo -u flectra bash -c '/opt/flectra/flectra.py'

  # Quitar la terminal de bash asignada al usuario del sistema
    echo ""
    echo "      Quitando la terminal de bash asignada al usuario de sistema...."
    echo ""
    sudo usermod -s /usr/sbin/nologin flectra

  # Crear el servicio de systemd
    echo ""
    echo "      Creando el servicio de systemd..."
    echo ""
    echo '[Unit]'                                  | sudo tee    /etc/systemd/system/flectra.service
    echo 'Description=Flectra ERP'                 | sudo tee -a /etc/systemd/system/flectra.service
    echo 'After=network.target postgresql.service' | sudo tee -a /etc/systemd/system/flectra.service
    echo ''                                        | sudo tee -a /etc/systemd/system/flectra.service
    echo '[Service]'                               | sudo tee -a /etc/systemd/system/flectra.service
    echo 'Type=simple'                             | sudo tee -a /etc/systemd/system/flectra.service
    echo 'User=flectra'                            | sudo tee -a /etc/systemd/system/flectra.service
    echo 'Group=flectra'                           | sudo tee -a /etc/systemd/system/flectra.service
    echo 'ExecStart=/opt/flectra/flectra-start.py' | sudo tee -a /etc/systemd/system/flectra.service
    echo 'WorkingDirectory=/opt/flectra'           | sudo tee -a /etc/systemd/system/flectra.service
    echo 'StandardOutput=journal'                  | sudo tee -a /etc/systemd/system/flectra.service
    echo 'StandardError=inherit'                   | sudo tee -a /etc/systemd/system/flectra.service
    echo 'Restart=on-failure'                      | sudo tee -a /etc/systemd/system/flectra.service
    echo 'SyslogIdentifier=flectra'                | sudo tee -a /etc/systemd/system/flectra.service
    echo ''                                        | sudo tee -a /etc/systemd/system/flectra.service
    echo '[Install]'                               | sudo tee -a /etc/systemd/system/flectra.service
    echo 'WantedBy=multi-user.target'              | sudo tee -a /etc/systemd/system/flectra.service

  # Activar y lanzar el servicio
    echo ""
    echo "      Activando y lanzando el servicio..."
    echo ""
    sudo systemctl daemon-reload
    sudo systemctl enable flectra
    sudo systemctl start flectra
    sudo systemctl status flectra --no-pager

  # Notificar fin de ejecución del script
    echo ""
    echo "      Ejecución del script, finalizada."
    echo ""
    echo "        Flectra se ha instalado y configurado. Se ha creado e iniciado el servicio en systemd. El estado actual del servicio es:"
    echo ""
    sudo systemctl status flectra.service --no-pager
    echo ""
    vIPLocal=$(hostname -I | sed 's- --g')
    echo ""
    echo "        Para configurar la base de datos accede a http://$vIPLocal:7073"
    echo ""

elif [ $cVersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Flectra para Ubuntu 22.04 LTS (Jammy Jellyfish)...${cFinColor}"
  echo ""

  echo ""
  echo "    Instalando Flectra clonando el repo oficial de gitlab..."
  echo ""

  # Descargar paquetes necesarios para la correcta ejecución del script
    echo ""
    echo "      Descargando paquetes necesarios para la correcta ejecución del script..."
    echo ""
    sudo apt-get -y update
    sudo apt-get -y dist-upgrade
    sudo apt-get -y autoremove
    sudo apt-get -y autoclean

    sudo apt-get -y install curl
    sudo apt-get -y install gpg
    sudo apt-get -y install wget
    sudo apt-get -y install gsfonts
    sudo apt-get -y install fonts-freefont-ttf
    sudo apt-get -y install fonts-dejavu
    sudo apt-get -y install postgresql
    sudo apt-get -y install postgresql-server-dev-all
    sudo apt-get -y install build-essential
    sudo apt-get -y install python3-dev
    sudo apt-get -y install python3-pip
    sudo apt-get -y install npm
    sudo apt-get -y install nodejs
    sudo apt-get -y install git
    sudo apt-get -y install libldap2-dev
    sudo apt-get -y install libxml2-dev
    sudo apt-get -y install libxslt1-dev
    sudo apt-get -y install libjpeg-dev
    sudo apt-get -y install unzip
    sudo apt-get -y install libsasl2-dev
    sudo apt-get -y install libldap2-dev
    sudo apt-get -y install libssl-dev
    sudo apt-get -y install python3.11
    sudo apt-get -y install python3.11-venv
    sudo apt-get -y install python3.11-dev

  # Crear el usuario
    echo ""
    echo "      Creando el usuario del sistema..."
    echo ""
    sudo adduser --system --group --home /opt/flectra flectra
    sudo su - postgres -c "createuser -s flectra"

  # Asignar bash como terminal del usuario del sistema
    echo ""
    echo "      Asignando bash como terminal del usuario de sistema..."
    echo ""
    sudo usermod -s /bin/bash flectra
    #sudo getent passwd flectra

  # Determinar la última versión disponible de Flectra
    echo ""
    echo "      Determinando la última versión disponible..."
    echo ""
    vUltVersFlectra=$(curl -ksL download.flectrahq.com | sed 's->->\n-g' | grep href | grep deb | head -n1 | cut -d '"' -f2 | cut -d '/' -f2)
    vCanalUltVers=$(curl -ksL download.flectrahq.com | sed 's->->\n-g' | grep href | grep deb | head -n1 | cut -d '"' -f2 | cut -d '/' -f3)
    echo "      La última versión disponible es la $vUltVersFlectra del canal $vCanalUltVers"
    echo ""

  # Clonar el repo
    echo ""
    echo "      Clonando el repo..."
    echo ""
    sudo rm -rf /opt/flectra/Code/
    sudo su -s /bin/bash -c "\
      cd /opt/flectra/                                                                        && \
      git clone --depth=1 --branch=$vUltVersFlectra https://gitlab.com/flectra-hq/flectra.git && \
      mv /opt/flectra/flectra /opt/flectra/Code
    " flectra

  # Crear el entorno virtual
    echo ""
    echo "      Creando el entorno virtual..."
    echo ""
    sudo rm -rf /opt/flectra/venv/
    sudo su -s /bin/bash -c '\
      mkdir /opt/flectra/venv/                            && \
      python3.11 -m venv /opt/flectra/venv                && \
      source /opt/flectra/venv/bin/activate               && \
      pip install cython                                  && \
      pip install wheel                                   && \
      pip install -r /opt/flectra/Code/requirements.txt   && \
      deactivate \
    ' flectra

  # Crear el archivo de configuración
    echo ""
    echo "      Creando el archivo de configuración..."
    echo ""
    echo '[options]'                              | sudo tee    /opt/flectra/flectra.conf
    echo 'admin_passwd = admin'                   | sudo tee -a /opt/flectra/flectra.conf
    echo 'db_host = False'                        | sudo tee -a /opt/flectra/flectra.conf
    echo 'db_port = False'                        | sudo tee -a /opt/flectra/flectra.conf
    echo 'db_user = flectra'                      | sudo tee -a /opt/flectra/flectra.conf
    echo 'db_password = False'                    | sudo tee -a /opt/flectra/flectra.conf
    echo 'addons_path = /opt/flectra/Code/addons' | sudo tee -a /opt/flectra/flectra.conf
    echo 'default_productivity_apps = True'       | sudo tee -a /opt/flectra/flectra.conf
    echo 'logfile = /var/log/flectra/flectra.log' | sudo tee -a /opt/flectra/flectra.conf
    sudo chown flectra:flectra /opt/flectra/flectra.conf

  # Crear las carpetas para los logs
    echo ""
    echo "      Creando las carpetas para los logs..."
    echo ""
    sudo mkdir -p /var/log/flectra/
    sudo chown flectra:flectra /var/log/flectra/

  # Crear el lanzador
    echo ""
    echo "      Creando el lanzador..."
    echo ""
    echo '#!/opt/flectra/venv/bin/python3'                             | sudo tee    /opt/flectra/flectra-start.py
    echo ''                                                            | sudo tee -a /opt/flectra/flectra-start.py
    echo 'import sys'                                                  | sudo tee -a /opt/flectra/flectra-start.py
    echo 'import os'                                                   | sudo tee -a /opt/flectra/flectra-start.py
    echo ''                                                            | sudo tee -a /opt/flectra/flectra-start.py
    echo '# Agrega el paquete flectra al path'                         | sudo tee -a /opt/flectra/flectra-start.py
    echo 'sys.path.insert(0, "/opt/flectra/Code")'                     | sudo tee -a /opt/flectra/flectra-start.py
    echo ''                                                            | sudo tee -a /opt/flectra/flectra-start.py
    echo 'import flectra'                                              | sudo tee -a /opt/flectra/flectra-start.py
    echo ''                                                            | sudo tee -a /opt/flectra/flectra-start.py
    echo 'if __name__ == "__main__":'                                  | sudo tee -a /opt/flectra/flectra-start.py
    echo '  # Simula sys.argv como si ejecutaras desde consola'        | sudo tee -a /opt/flectra/flectra-start.py
    echo '  sys.argv = ["flectra", "-c", "/opt/flectra/flectra.conf"]' | sudo tee -a /opt/flectra/flectra-start.py
    echo '  flectra.cli.main()'                                        | sudo tee -a /opt/flectra/flectra-start.py
    sudo chmod +x /opt/flectra/flectra-start.py
    sudo chown flectra:flectra /opt/flectra/flectra-start.py

  # Ejecutar Flectra por primera vez
    #echo ""
    #echo "      Ejecutando Flectra por primera vez..."
    #echo ""
    #sudo -u flectra bash -c '/opt/flectra/flectra.py'

  # Quitar la terminal de bash asignada al usuario del sistema
    echo ""
    echo "      Quitando la terminal de bash asignada al usuario de sistema...."
    echo ""
    sudo usermod -s /usr/sbin/nologin flectra

  # Crear el servicio de systemd
    echo ""
    echo "      Creando el servicio de systemd..."
    echo ""
    echo '[Unit]'                                  | sudo tee    /etc/systemd/system/flectra.service
    echo 'Description=Flectra ERP'                 | sudo tee -a /etc/systemd/system/flectra.service
    echo 'After=network.target postgresql.service' | sudo tee -a /etc/systemd/system/flectra.service
    echo ''                                        | sudo tee -a /etc/systemd/system/flectra.service
    echo '[Service]'                               | sudo tee -a /etc/systemd/system/flectra.service
    echo 'Type=simple'                             | sudo tee -a /etc/systemd/system/flectra.service
    echo 'User=flectra'                            | sudo tee -a /etc/systemd/system/flectra.service
    echo 'Group=flectra'                           | sudo tee -a /etc/systemd/system/flectra.service
    echo 'ExecStart=/opt/flectra/flectra-start.py' | sudo tee -a /etc/systemd/system/flectra.service
    echo 'WorkingDirectory=/opt/flectra'           | sudo tee -a /etc/systemd/system/flectra.service
    echo 'StandardOutput=journal'                  | sudo tee -a /etc/systemd/system/flectra.service
    echo 'StandardError=inherit'                   | sudo tee -a /etc/systemd/system/flectra.service
    echo 'Restart=on-failure'                      | sudo tee -a /etc/systemd/system/flectra.service
    echo 'SyslogIdentifier=flectra'                | sudo tee -a /etc/systemd/system/flectra.service
    echo ''                                        | sudo tee -a /etc/systemd/system/flectra.service
    echo '[Install]'                               | sudo tee -a /etc/systemd/system/flectra.service
    echo 'WantedBy=multi-user.target'              | sudo tee -a /etc/systemd/system/flectra.service

  # Activar y lanzar el servicio
    echo ""
    echo "      Activando y lanzando el servicio..."
    echo ""
    sudo systemctl daemon-reload
    sudo systemctl enable flectra
    sudo systemctl start flectra
    sudo systemctl status flectra --no-pager

  # Notificar fin de ejecución del script
    echo ""
    echo "      Ejecución del script, finalizada."
    echo ""
    echo "        Flectra se ha instalado y configurado. Se ha creado e iniciado el servicio en systemd. El estado actual del servicio es:"
    echo ""
    sudo systemctl status flectra.service --no-pager
    echo ""
    vIPLocal=$(hostname -I | sed 's- --g')
    echo ""
    echo "        Para configurar la base de datos accede a http://$vIPLocal:7073"
    echo ""

elif [ $cVersUbuntu == "focal" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Flectra para Ubuntu 20.04 LTS (Focal Fossa)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 20.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Flectra para Ubuntu 18.04 LTS (Bionic Beaver)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 18.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Flectra para Ubuntu 16.04 LTS (Xenial Xerus)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 16.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "trusty" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de Flectra para Ubuntu 14.04 LTS (Trusty Tahr)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

else

  echo ""
  echo -e "${cColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${cFinColor}"
  echo ""

fi
