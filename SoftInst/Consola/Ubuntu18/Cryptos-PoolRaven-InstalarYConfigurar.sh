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
  opciones=(1 "Borrar la cartera existente" off
            2 "Crear usuario sin privilegios para ejecutar la pool (Obligatorio)" on
            3 "Instalar la última versión de la cartera de Ravencoin" on
            4 "Crear comandos de terminal para administrar la cartera" on
            5 "Agregar auto-ejecución del daemon de cartera" on
            6 "Agregar auto-ejecución gráfica de la cartera" on
            7 "Crear acceso para ejecución gráfica de la cartera" on
            8 "Instalar escritorio y algunas utilidades de terminal" off
            9 "Reparar permisos (Obligatorio)" on
            10 "Reniciar el sistema" off)
  choices=$("${menu[@]}" "${opciones[@]}" 2>&1 >/dev/tty)
  clear

  for choice in $choices
    do
      case $choice in

        1)

          echo ""
          echo -e "${ColorVerde}-------------------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Borrando cartera y configuración existente...${FinColor}"
          echo -e "${ColorVerde}-------------------------------------------------${FinColor}"
          echo ""
          
          ## Parar daemon, si es que se está ejecutando
             sudo su $UsuarioDaemon -c "/home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh"

          ## Borrar software de cartera
             sudo rm -rf /home/$UsuarioDaemon/$CarpetaSoftRVN/

          ## Borrar archivos de cartera
             sudo rm -rf /home/$UsuarioDaemon/.raven/

          ## Borrar autoejecución gráfica
             sudo rm -rf /home/$UsuarioDaemon/.config/autostart/raven.desktop

          ## Borrar acceso directo del menu
             sudo rm -rf /home/$UsuarioDaemon/.local/share/applications/raven.desktop
        ;;

        2)

          echo ""
          echo -e "${ColorVerde}-------------------------------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Creando el usuario para ejecutar y administrar la pool...${FinColor}"
          echo -e "${ColorVerde}-------------------------------------------------------------${FinColor}"
          echo ""

          sudo useradd -d /home/$UsuarioDaemon/ -s /bin/bash $UsuarioDaemon

          echo ""
          echo "  Ingresa la nueva contraseña para el usuario $UsuarioDaemon"
          echo ""
          sudo passwd $UsuarioDaemon

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
          mkdir -p ~/SoftInst/Ravencoin/ 2> /dev/null
          rm -rf ~/SoftInst/Ravencoin/*
          cd ~/SoftInst/Ravencoin/
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
          wget https://github.com/RavenProject/Ravencoin/releases/download/v$UltVersRaven/raven-$UltVersRaven-x86_64-linux-gnu.zip
          echo ""
          echo "  Pidiendo el archivo en formato tar.gz..."
          echo ""
          wget https://github.com/RavenProject/Ravencoin/releases/download/v$UltVersRaven/raven-$UltVersRaven-x86_64-linux-gnu.tar.gz

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
          unzip ~/SoftInst/Ravencoin/raven-$UltVersRaven-x86_64-linux-gnu.zip
          mv ~/SoftInst/Ravencoin/linux/raven-$UltVersRaven-x86_64-linux-gnu.tar.gz ~/SoftInst/Ravencoin/
          rm -rf ~/SoftInst/Ravencoin/raven-$UltVersRaven-x86_64-linux-gnu.zip
          rm -rf ~/SoftInst/Ravencoin/linux/
          rm -rf ~/SoftInst/Ravencoin/__MACOSX/
          ## Comprobar si el paquete tar está instalado. Si no lo está, instalarlo.
             if [[ $(dpkg-query -s tar 2>/dev/null | grep installed) == "" ]]; then
               echo ""
               echo "tar no está instalado. Iniciando su instalación..."
               echo ""
               sudo apt-get -y update
               sudo apt-get -y install tar
             fi
          tar -xf ~/SoftInst/Ravencoin/raven-$UltVersRaven-x86_64-linux-gnu.tar.gz
          rm -rf ~/SoftInst/Ravencoin/raven-$UltVersRaven-x86_64-linux-gnu.tar.gz

          echo ""
          echo "  Creando carpetas y archivos necesarios para ese usuario..."
          echo ""
          sudo mkdir -p /home/$UsuarioDaemon/ 2> /dev/null
          sudo mkdir -p /home/$UsuarioDaemon/.raven/
          sudo touch /home/$UsuarioDaemon/.raven/raven.conf
          sudo su -c 'echo "rpcuser=user1"      > /home/$UsuarioDaemon/.raven/raven.conf'
          sudo su -c 'echo "rpcpassword=pass1" >> /home/$UsuarioDaemon/.raven/raven.conf'
          sudo su -c 'echo "prune=550"         >> /home/$UsuarioDaemon/.raven/raven.conf'
          sudo su -c 'echo "daemon=1"          >> /home/$UsuarioDaemon/.raven/raven.conf'
          sudo rm -rf /home/$UsuarioDaemon/$CarpetaSoftRVN/
          sudo mv ~/SoftInst/Ravencoin/raven-$UltVersRaven/ /home/$UsuarioDaemon/$CarpetaSoftRVN/
          sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/ -R
          sudo find /home/$UsuarioDaemon -type d -exec chmod 775 {} \;
          sudo find /home/$UsuarioDaemon -type f -exec chmod 664 {} \;
          sudo find /home/$UsuarioDaemon/$CarpetaSoftRVN/bin -type f -exec chmod +x {} \;

          echo ""
          echo "  Arrancando ravencoind..."
          echo ""
          sudo su $UsuarioDaemon -c /home/$UsuarioDaemon/$CarpetaSoftRVN/bin/ravend
          sleep 5
          sudo touch /home/$UsuarioDaemon/pooladdress-rvn.txt
          sudo chmod 777 /home/$UsuarioDaemon/pooladdress-rvn.txt
          sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/ -R
          sudo su $UsuarioDaemon -c "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/raven-cli getnewaddress" > /home/$UsuarioDaemon/pooladdress-rvn.txt
          sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/pooladdress-rvn.txt
          echo ""
          echo "  La dirección para recibir ravencoins es:"
          echo ""
          sudo cat /home/$UsuarioDaemon/pooladdress-rvn.txt
          DirCartRVN=$(sudo cat /home/$UsuarioDaemon/pooladdress-rvn.txt)
          echo ""

          ## Reparación de permisos

             sudo chmod +x /home/$UsuarioDaemon/$CarpetaSoftRVN/bin/*
             sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/ -R

          ## Parar el daemon

             sudo su $UsuarioDaemon -c "/home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh"

        ;;

        4)

          echo ""
          echo -e "${ColorVerde}-------------------------------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Creando comandos de terminal para administrar la cartera...${FinColor}"
          echo -e "${ColorVerde}-------------------------------------------------------------${FinColor}"
          echo ""

          mkdir -p ~/ComandosCli/ 2> /dev/null

          echo '#!/bin/bash'                                                                   > ~/ComandosCli/raven-daemon-iniciar.sh
          echo ""                                                                             >> ~/ComandosCli/raven-daemon-iniciar.sh
          echo 'echo ""'                                                                      >> ~/ComandosCli/raven-daemon-iniciar.sh
          echo 'echo "  Iniciando el daemon ravend..."'                                       >> ~/ComandosCli/raven-daemon-iniciar.sh
          echo 'echo ""'                                                                      >> ~/ComandosCli/raven-daemon-iniciar.sh
          echo "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/ravend"                              >> ~/ComandosCli/raven-daemon-iniciar.sh
          chmod +x                                                                               ~/ComandosCli/raven-daemon-iniciar.sh

          echo '#!/bin/bash'                                                                   > ~/ComandosCli/raven-cartera-info.sh
          echo ""                                                                             >> ~/ComandosCli/raven-cartera-info.sh
          echo 'echo ""'                                                                      >> ~/ComandosCli/raven-cartera-info.sh
          echo 'echo "  Mostrando info de la cartera Raven..."'                               >> ~/ComandosCli/raven-cartera-info.sh
          echo 'echo ""'                                                                      >> ~/ComandosCli/raven-cartera-info.sh
          echo "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/raven-cli getwalletinfo | jq"        >> ~/ComandosCli/raven-cartera-info.sh
          chmod +x                                                                               ~/ComandosCli/raven-cartera-info.sh

          echo '#!/bin/bash'                                                                   > ~/ComandosCli/raven-daemon-parar.sh
          echo ""                                                                             >> ~/ComandosCli/raven-daemon-parar.sh
          echo 'echo ""'                                                                      >> ~/ComandosCli/raven-daemon-parar.sh
          echo 'echo "  Parando el daemon ravend..."'                                         >> ~/ComandosCli/raven-daemon-parar.sh
          echo 'echo ""'                                                                      >> ~/ComandosCli/raven-daemon-parar.sh
          echo "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/raven-cli stop"                      >> ~/ComandosCli/raven-daemon-parar.sh
          chmod +x                                                                               ~/ComandosCli/raven-daemon-parar.sh

          echo '#!/bin/bash'                                                                   > ~/ComandosCli/raven-qt-iniciar.sh
          echo ""                                                                             >> ~/ComandosCli/raven-qt-iniciar.sh
          echo 'echo ""'                                                                      >> ~/ComandosCli/raven-qt-iniciar.sh
          echo 'echo "  Iniciando raven-qt..."'                                               >> ~/ComandosCli/raven-qt-iniciar.sh
          echo 'echo ""'                                                                      >> ~/ComandosCli/raven-qt-iniciar.sh
          echo "/home/$UsuarioDaemon/ComandosCli/raven-daemon-parar.sh"                       >> ~/ComandosCli/raven-qt-iniciar.sh
          echo "sleep 5"                                                                      >> ~/ComandosCli/raven-qt-iniciar.sh
          echo "/home/$UsuarioDaemon/$CarpetaSoftRVN/bin/raven-qt -min -testnet=0 -regtest=0" >> ~/ComandosCli/raven-qt-iniciar.sh
          chmod +x                                                                               ~/ComandosCli/raven-qt-iniciar.sh

          sudo mv ~/ComandosCli/ /home/$UsuarioDaemon/
          sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/

        ;;

        5)

          echo ""
          echo -e "${ColorVerde}---------------------------------------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Agregando auto-ejecución del daemon a los ComandosPostArranque...${FinColor}"
          echo -e "${ColorVerde}---------------------------------------------------------------------${FinColor}"
          echo ""

          sudo chmod +x /home/$UsuarioDaemon/ComandosCli/raven-daemon-iniciar.sh
          sudo su -c 'echo "su "'"$UsuarioDaemon"'" -c '/home/"$UsuarioDaemon"/ComandosCli/raven-daemon-iniciar.sh'" >> /root/scripts/ComandosPostArranque.sh'

        ;;

        6)

          echo ""
          echo -e "${ColorVerde}-----------------------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Agregando auto-ejecución gráfica de la cartera...${FinColor}"
          echo -e "${ColorVerde}-----------------------------------------------------${FinColor}"
          echo ""

          mkdir -p ~/.config/autostart/ 2> /dev/null

          echo "[Desktop Entry]"                                             > ~/.config/autostart/raven.desktop
          echo "Name=Raven GUI"                                             >> ~/.config/autostart/raven.desktop
          echo "Type=Application"                                           >> ~/.config/autostart/raven.desktop
          echo "Exec=/home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh"  >> ~/.config/autostart/raven.desktop
          echo "Terminal=false"                                             >> ~/.config/autostart/raven.desktop
          echo "Hidden=false"                                               >> ~/.config/autostart/raven.desktop

          sudo mkdir -p /home/$UsuarioDaemon/.config/autostart/ 2> /dev/null
          sudo mv ~/.config/autostart/raven.desktop /home/$UsuarioDaemon/.config/autostart/
          sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/

        ;;

        7)

          echo ""
          echo -e "${ColorVerde}----------------------------------------------------------${FinColor}"
          echo -e "${ColorVerde}  Creando acceso para ejecución gráfica de la cartera...${FinColor}"
          echo -e "${ColorVerde}----------------------------------------------------------${FinColor}"
          echo ""

          mkdir -p ~/.local/share/applications/ 2> /dev/null

          echo "[Desktop Entry]"                                            > ~/.local/share/applications/raven.desktop
          echo "Name=Raven GUI"                                            >> ~/.local/share/applications/raven.desktop
          echo "Type=Application"                                          >> ~/.local/share/applications/raven.desktop
          echo "Exec=/home/$UsuarioDaemon/ComandosCli/raven-qt-iniciar.sh" >> ~/.local/share/applications/raven.desktop
          echo "Terminal=false"                                            >> ~/.local/share/applications/raven.desktop
          echo "Hidden=false"                                              >> ~/.local/share/applications/raven.desktop
          echo "Categories=Cryptos"                                        >> ~/.local/share/applications/raven.desktop
          #echo "Icon="                                                    >> ~/.local/share/applications/raven.desktop

          sudo mkdir -p /home/$UsuarioDaemon/.local/share/applications/ 2> /dev/null
          sudo mv ~/.local/share/applications/raven.desktop /home/$UsuarioDaemon/.local/share/applications/
          sudo chown $UsuarioDaemon:$UsuarioDaemon /home/$UsuarioDaemon/

        ;;

        8)

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

        9)

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

        10)

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
echo -e "${ColorVerde}-------------------------------------------------------------------------${FinColor}"
echo -e "${ColorVerde}Script de instalación de una pool de minería de criptomonedas, finalzado.${FinColor}"
echo -e "${ColorVerde}-------------------------------------------------------------------------${FinColor}"
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

