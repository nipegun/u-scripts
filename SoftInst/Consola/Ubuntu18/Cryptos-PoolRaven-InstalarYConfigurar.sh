#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#--------------------------------------------------------------------------------------
#  Script de NiPeGun para instalar y configurar la pool de Ravencoin en Ubuntu 18 LTS
#--------------------------------------------------------------------------------------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

UsuarioDaemon="pooladmin"
CarpetaSoftRVN="CoreRVN"

echo ""
echo -e "${ColorVerde}-------------------------------------------------------------${FinColor}"
echo -e "${ColorVerde}Iniciando el script de instalación de la pool de Ravencoin...${FinColor}"
echo -e "${ColorVerde}-------------------------------------------------------------${FinColor}"
echo ""

## Comprobar si el paquete dialog está instalado. Si no lo está, instalarlo.
   if [[ $(dpkg-query -s dialog 2>/dev/null | grep installed) == "" ]]; then
     echo ""
     echo "dialog no está instalado. Iniciando su instalación..."
     echo ""
     sudo apt-get -y update
     sudo apt-get -y install dialog
   fi

menu=(dialog --timeout 5 --checklist "Marca lo que quieras instalar:" 22 76 16)
  opciones=(1 "Crear usuario sin privilegios para ejecutar la pool (Obligatorio)" on
            2 "Borrar la cartera y configuración anterior" off
            3 "Instalar cartera de Ravencoin" off
            4 "Crear contraseña para el usuario $UsuarioDaemon" on
            5 "Instalar escritorio y algunas utilidades de terminal" off
            6 "Reparar permisos (Obligatorio)" on
            7 "Reniciar el sistema" off)
  choices=$("${menu[@]}" "${opciones[@]}" 2>&1 >/dev/tty)
  clear

  for choice in $choices
    do
      case $choice in

        1)

          echo ""
          echo -e "${ColorVerde}-------------------------------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Creando el usuario para ejecutar y administrar la pool...${FinColor}"
          echo -e "${ColorVerde}-------------------------------------------------------------${FinColor}"
          echo ""

          sudo useradd -d /home/$UsuarioDaemon/ -s /bin/bash $UsuarioDaemon

          ## Reparación de permisos

             sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/ -R
        ;;

        2)

          echo ""
          echo -e "${ColorVerde}-----------------------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Borrando carteras y configuraciones anteriores...${FinColor}"
          echo -e "${ColorVerde}-----------------------------------------------------${FinColor}"
          echo ""

          ## Raven
             sudo rm -rf /home/$UsuarioDaemon/.raven/

          ## Reparación de permisos
             sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/ -R
        ;;

        3)

          echo ""
          echo -e "${ColorVerde}-------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Instalando la cartera de raven...${FinColor}"
          echo -e "${ColorVerde}-------------------------------------${FinColor}"
          echo ""

          echo "  Determinando la última versión de raven core..."
          echo ""
          ## Comprobar si el paquete curl está instalado. Si no lo está, instalarlo.
             if [[ $(dpkg-query -s curl 2>/dev/null | grep installed) == "" ]]; then
               echo ""
               echo "curl no está instalado. Iniciando su instalación..."
               echo ""
               sudo apt-get -y update
               sudo apt-get -y install curl
             fi
          UltVersRaven=$(curl --silent https://github.com/RavenProject/Ravencoin/releases/latest | cut -d '/' -f 8 | cut -d '"' -f 1 | cut -c2-)
          echo ""
          echo "  La última versión de raven es la $UltVersRaven"
          echo ""

          echo ""
          echo "  Intentando descargar el archivo comprimido de la última versión..."
          echo ""
          sudo mkdir -p /root/SoftInst/Ravencoin/ 2> /dev/null
          sudo rm -rf /root/SoftInst/Ravencoin/*
          sudo cd /root/SoftInst/Ravencoin/
          ## Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
             if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
               echo ""
               echo "wget no está instalado. Iniciando su instalación..."
               echo ""
               apt-get -y update
               apt-get -y install wget
             fi
          echo ""
          echo "  Pidiendo el archivo en formato zip..."
          echo ""
          sudo wget https://github.com/RavenProject/Ravencoin/releases/download/v$UltVersRaven/raven-$UltVersRaven-x86_64-linux-gnu.zip
          echo ""
          echo "  Pidiendo el archivo en formato tar.gz..."
          echo ""
          sudo wget https://github.com/RavenProject/Ravencoin/releases/download/v$UltVersRaven/raven-$UltVersRaven-x86_64-linux-gnu.tar.gz

          echo ""
          echo "Descomprimiendo el archivo..."
          echo ""
          ## Comprobar si el paquete zip está instalado. Si no lo está, instalarlo.
             if [[ $(dpkg-query -s zip 2>/dev/null | grep installed) == "" ]]; then
               echo ""
               echo "zip no está instalado. Iniciando su instalación..."
               echo ""
               sudo apt-get -y update
               sudo apt-get -y install zip
             fi
          sudo unzip /root/SoftInst/Ravencoin/raven-$UltVersRaven-x86_64-linux-gnu.zip
          sudo mv /root/SoftInst/Ravencoin/linux/raven-$UltVersRaven-x86_64-linux-gnu.tar.gz /root/SoftInst/Ravencoin/
          sudo rm -rf /root/SoftInst/Ravencoin/raven-$UltVersRaven-x86_64-linux-gnu.zip
          sudo rm -rf /root/SoftInst/Ravencoin/linux/
          sudo rm -rf /root/SoftInst/Ravencoin/__MACOSX/
          ## Comprobar si el paquete tar está instalado. Si no lo está, instalarlo.
             if [[ $(dpkg-query -s tar 2>/dev/null | grep installed) == "" ]]; then
               echo ""
               echo "tar no está instalado. Iniciando su instalación..."
               echo ""
               sudo apt-get -y update
               sudo apt-get -y install tar
             fi
          sudo tar -xf /root/SoftInst/Ravencoin/raven-$UltVersRaven-x86_64-linux-gnu.tar.gz
          sudo rm -rf /root/SoftInst/Ravencoin/raven-$UltVersRaven-x86_64-linux-gnu.tar.gz

          echo ""
          echo "  Creando carpetas y archivos necesarios para ese usuario..."
          echo ""
          sudo mkdir -p /home/$UsuarioDaemon/ 2> /dev/null
          sudo mkdir -p /home/$UsuarioDaemon/.raven/
          sudo touch /home/$UsuarioDaemon/.raven/raven.conf
          sudo echo "rpcuser=user1"      > /home/$UsuarioDaemon/.raven/raven.conf
          sudo echo "rpcpassword=pass1" >> /home/$UsuarioDaemon/.raven/raven.conf
          sudo echo "prune=550"         >> /home/$UsuarioDaemon/.raven/raven.conf
          sudo echo "daemon=1"          >> /home/$UsuarioDaemon/.raven/raven.conf
          sudo rm -rf /home/$UsuarioDaemon/$CarpetaSoftRVN/
          sudo mv /root/SoftInst/Ravencoin/raven-$UltVersRaven/ /home/$UsuarioDaemon/$CarpetaSoftRVN/
          sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/ -R
          sudo find /home/$UsuarioDaemon -type d -exec chmod 775 {} \;
          sudo find /home/$UsuarioDaemon -type f -exec chmod 664 {} \;
          sudo find /home/$UsuarioDaemon/$CarpetaSoftRVN/bin -type f -exec chmod +x {} \;

          echo ""
          echo "  Arrancando ravencoind..."
          echo ""
          sudo su $UsuarioDaemon -c /home/$UsuarioDaemon/$CarpetaSoftRVN/bin/ravend
          sleep 5
          sudo su $UsuarioDaemon -c "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/raven-cli getnewaddress" > /home/$UsuarioDaemon/pooladdress-rvn.txt
          sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/pooladdress-rvn.txt
          echo ""
          echo "  La dirección para recibir ravencoins es:"
          echo ""
          sudo cat /home/$UsuarioDaemon/pooladdress-rvn.txt
          DirCartRVN=$(sudo cat /home/$UsuarioDaemon/pooladdress-rvn.txt)
          echo ""

          ## Comandos de terminal para raven

            sudo  mkdir -p /home/$UsuarioDaemon/ComandosCli/ 2> /dev/null

             sudo echo '#!/bin/bash'                                                                   > /home/$UsuarioDaemon/ComandosCli/raven-daemon-iniciar.sh
             sudo echo ""                                                                             >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-iniciar.sh
             sudo echo 'echo ""'                                                                      >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-iniciar.sh
             sudo echo 'echo "  Iniciando el daemon ravend..."'                                       >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-iniciar.sh
             sudo echo 'echo ""'                                                                      >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-iniciar.sh
             sudo echo "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/ravend"                              >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-iniciar.sh
             sudo chmod +x                                                                               /home/$UsuarioDaemon/ComandosCli/raven-daemon-iniciar.sh

             sudo echo '#!/bin/bash'                                                                   > /home/$UsuarioDaemon/ComandosCli/raven-cartera-info.sh
             sudo echo ""                                                                             >> /home/$UsuarioDaemon/ComandosCli/raven-cartera-info.sh
             sudo echo 'echo ""'                                                                      >> /home/$UsuarioDaemon/ComandosCli/raven-cartera-info.sh
             sudo echo 'echo "  Mostrando info de la cartera Raven..."'                               >> /home/$UsuarioDaemon/ComandosCli/raven-cartera-info.sh
             sudo echo 'echo ""'                                                                      >> /home/$UsuarioDaemon/ComandosCli/raven-cartera-info.sh
             sudo echo "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/raven-cli getwalletinfo | jq"        >> /home/$UsuarioDaemon/ComandosCli/raven-cartera-info.sh
             sudo chmod +x                                                                               /home/$UsuarioDaemon/ComandosCli/raven-cartera-info.sh

             sudo echo '#!/bin/bash'                                                                   > /home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh
             sudo echo ""                                                                             >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh
             sudo echo 'echo ""'                                                                      >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh
             sudo echo 'echo "  Parando el daemon ravend..."'                                         >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh
             sudo echo 'echo ""'                                                                      >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh
             sudo echo "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/raven-cli stop"                      >> /home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh
             sudo chmod +x                                                                               /home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh

             sudo echo '#!/bin/bash'                                                                   > /home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh
             sudo echo ""                                                                             >> /home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh
             sudo echo 'echo ""'                                                                      >> /home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh
             sudo echo 'echo "  Iniciando raven-qt..."'                                               >> /home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh
             sudo echo 'echo ""'                                                                      >> /home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh
             sudo echo "/home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh"                       >> /home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh
             sudo echo "sleep 5"                                                                      >> /home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh
             sudo echo "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/raven-qt -min -testnet=0 -regtest=0" >> /home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh
             sudo chmod +x                                                                               /home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh

          ## Autoejecución de Ravencoin al iniciar el sistema

             sudo echo ""
             sudo echo "  Agregando ravend a los ComandosPostArranque..."
             sudo echo ""
             sudo echo "chmod +x /home/$UsuarioDaemon/ComandosCli/raven-daemon-iniciar.sh"
             sudo echo "su "$UsuarioDaemon" -c '/home/"$UsuarioDaemon"/ComandosCli/raven-daemon-iniciar.sh'" >> /root/scripts/ComandosPostArranque.sh

          ## Icono de lanzamiento en el menú gráfico

             echo ""
             echo "  Agregando la aplicación gráfica al menú..."
             echo ""
             sudo mkdir -p /home/$UsuarioDaemon/.local/share/applications/ 2> /dev/null
             sudo echo "[Desktop Entry]"                                            > /home/$UsuarioDaemon/.local/share/applications/raven.desktop
             sudo echo "Name=Raven GUI"                                            >> /home/$UsuarioDaemon/.local/share/applications/raven.desktop
             sudo echo "Type=Application"                                          >> /home/$UsuarioDaemon/.local/share/applications/raven.desktop
             sudo echo "Exec=/home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh" >> /home/$UsuarioDaemon/.local/share/applications/raven.desktop
             sudo echo "Terminal=false"                                            >> /home/$UsuarioDaemon/.local/share/applications/raven.desktop
             sudo echo "Hidden=false"                                              >> /home/$UsuarioDaemon/.local/share/applications/raven.desktop
             sudo echo "Categories=Cryptos"                                        >> /home/$UsuarioDaemon/.local/share/applications/raven.desktop
             #echo "Icon="                                                    >> /home/$UsuarioDaemon/.local/share/applications/raven.desktop

          ## Autoejecución gráfica de Ravencoin

             echo ""
             echo "  Creando el archivo de autoejecución de raven-qt para escritorio..."
             echo ""
             sudo mkdir -p /home/$UsuarioDaemon/.config/autostart/ 2> /dev/null
             sudo echo "[Desktop Entry]"                                             > /home/$UsuarioDaemon/.config/autostart/raven.desktop
             sudo echo "Name=Raven GUI"                                             >> /home/$UsuarioDaemon/.config/autostart/raven.desktop
             sudo echo "Type=Application"                                           >> /home/$UsuarioDaemon/.config/autostart/raven.desktop
             sudo echo "Exec=/home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh"  >> /home/$UsuarioDaemon/.config/autostart/raven.desktop
             sudo echo "Terminal=false"                                             >> /home/$UsuarioDaemon/.config/autostart/raven.desktop
             sudo echo "Hidden=false"                                               >> /home/$UsuarioDaemon/.config/autostart/raven.desktop

          ## Reparación de permisos

             sudo chmod +x /home/$UsuarioDaemon/$CarpetaSoftRVN/bin/*
             sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/ -R

          ## Parar el daemon

             sudo su $UsuarioDaemon -c "/home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh"

        ;;

        4)

          echo ""
          echo -e "${ColorVerde}-------------------------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Cambiando la contraseña del usuario $UsuarioDaemon...${FinColor}"
          echo -e "${ColorVerde}-------------------------------------------------------${FinColor}"
          echo ""

          sudo passwd $UsuarioDaemon

        ;;

        5)

          echo ""
          echo -e "${ColorVerde}----------------------------${FinColor}"
          echo -e "${ColorVerde}  Instalando escritorio...${FinColor}"
          echo -e "${ColorVerde}----------------------------${FinColor}"
          echo ""

          ## Comprobar si el paquete tasksel está instalado. Si no lo está, instalarlo.
             if [[ $(dpkg-query -s tasksel 2>/dev/null | grep installed) == "" ]]; then
               echo ""
               echo "tasksel no está instalado. Iniciando su instalación..."
               echo ""
               sudo apt-get -y update
               sudo apt-get -y install tasksel
             fi
          sudo tasksel install mate-desktop
          sudo apt-get -y install xrdp jq
          sudo systemctl set-default -f multi-user.target

        ;;

        6)

          echo ""
          echo -e "${ColorVerde}-------------------------${FinColor}"
          echo -e "${ColorVerde}  Reparando permisos...${FinColor}"
          echo -e "${ColorVerde}-------------------------${FinColor}"
          echo ""

          sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/

          ## Denegar a los otros usuarios del sistema el acceso a la carpeta del usuario 
             sudo find /home/$UsuarioDaemon -type d -exec chmod 750 {} \;
             sudo find /home/$UsuarioDaemon -type f -exec chmod 664 {} \;

          sudo find /home/$UsuarioDaemon/$CarpetaSoftRVN/bin/ -type f -exec chmod +x {} \;
          sudo find /home/$UsuarioDaemon/ -type f -iname "*.sh" -exec chmod +x {} \;

        ;;

        7)

          echo ""
          echo -e "${ColorVerde}-----------------------------${FinColor}"
          echo -e "${ColorVerde}  Reiniciando el sistema...${FinColor}"
          echo -e "${ColorVerde}-----------------------------${FinColor}"
          echo ""

          sudo shutdown -r now

        ;;

      esac

done

echo ""
echo -e "${ColorVerde}--------------------------------------------------------------------------${FinColor}"
echo -e "${ColorVerde}Script de instalación de una pool de minería de criptomonedas, finalzaado.${FinColor}"
echo -e "${ColorVerde}--------------------------------------------------------------------------${FinColor}"
echo ""

echo "RAVEN:"
echo "Recuerda editar el cortafuegos del ordenador para que acepte conexiones TCP en el puerto 8767."
echo "Si has instalado RavenCore en una MV de Proxmox agrega una regla a su cortauegos indicando:"
echo ""
echo "Dirección: out"
echo "Acción: ACCEPT"
echo "Protocolo: tcp"
echo "Puerto destino: 8767"
echo ""

