#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar x11vnc en Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/SoftInst/ParaCLI/x11vnc-InstalarYConfigurar.sh | sudo bash
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

  # Comprobar si el paquete dialog está instalado. Si no lo está, instalarlo.
    if [[ $(dpkg-query -s dialog 2>/dev/null | grep installed) == "" ]]; then
      echo ""
      echo -e "${vColorRojo}    El paquete dialog no está instalado. Iniciando su instalación...${vFinColor}"
      echo ""
      apt-get -y update && apt-get -y install dialog
      echo ""
    fi

  menu=(dialog --checklist "Cómo quieres instalar x11vnc:" 22 96 16)
    opciones=(
      1 "Instalar desactivando Wayland" off
      2 "Instalar sin desactivar Wayland" off
      3 "..." off
      4 "..." off
      5 "..." off
    )
  choices=$("${menu[@]}" "${opciones[@]}" 2>&1 >/dev/tty)
  clear

  for choice in $choices
    do
      case $choice in

        1)


          echo ""
          echo "  Instalando x11vnc desactivando Wayland..."
          echo ""

          echo ""
          echo "  Actualizando el sistema..."
          echo ""
          apt-get -y update && apt-get -y upgrade

          echo ""
          echo "  Instalando el paquete x11vnc..."
          echo ""
          apt-get -y install x11vnc

          echo ""
          echo "  Instalando el paquete net-tools para poder utilizar netstat en -auth guess..."
          echo ""
          apt-get -y install net-tools

          echo ""
          echo "  Creando el servicio de systemd..."
          echo ""
          echo "[Unit]"                                                                                                                                            > /etc/systemd/system/x11vnc.service
          echo "Description=x11vnc service"                                                                                                                       >> /etc/systemd/system/x11vnc.service
          echo "After=display-manager.service network.target syslog.target"                                                                                       >> /etc/systemd/system/x11vnc.service
          echo ""                                                                                                                                                 >> /etc/systemd/system/x11vnc.service
          echo "[Service]"                                                                                                                                        >> /etc/systemd/system/x11vnc.service
          echo "Type=simple"                                                                                                                                      >> /etc/systemd/system/x11vnc.service
#         echo "ExecStart=/usr/bin/x11vnc -forever -display :0 -auth guess -passwd Pass123"                                                                       >> /etc/systemd/system/x11vnc.service
#         echo "ExecStart=/usr/bin/x11vnc -display :0 -forever -shared -rfbauth /etc/x11vnc.passwd"                                                               >> /etc/systemd/system/x11vnc.service
#         echo "ExecStart=/usr/bin/x11vnc -display :0 -auth guess -forever -loop -noxdamage -repeat -localhost -rfbauth /etc/x11vnc.passwd -rfbport 5900 -shared" >> /etc/systemd/system/x11vnc.service
          echo "ExecStart=/usr/bin/x11vnc -auth /run/user/1000/gdm/Xauthority -passwd Pass123"                                                                    >> /etc/systemd/system/x11vnc.service
#          echo "ExecStart=/usr/bin/x11vnc -auth /run/user/1000/gdm/Xauthority -rfbauth /etc/x11vnc.passwd"                                                        >> /etc/systemd/system/x11vnc.service
          echo "ExecStop=/usr/bin/killall x11vnc"                                                                                                                 >> /etc/systemd/system/x11vnc.service
          echo "Restart=on-failure"                                                                                                                               >> /etc/systemd/system/x11vnc.service
          echo ""                                                                                                                                                 >> /etc/systemd/system/x11vnc.service
          echo "[Install]"                                                                                                                                        >> /etc/systemd/system/x11vnc.service
          echo "WantedBy=multi-user.target"                                                                                                                       >> /etc/systemd/system/x11vnc.service

          echo ""
          echo "  Recargando la configuración de los daemons..."
          echo ""
          systemctl daemon-reload

          echo ""
          echo "  Activando e iniciando el servicio x11vnc..."
          echo ""
          systemctl enable x11vnc.service --now

          echo ""
          echo "  Creando contraseña de usuario para x11vnc..."
          echo ""
          x11vnc -storepasswd /etc/x11vnc.passwd
          chmod 0400 /etc/x11vnc.passwd

          echo ""
          echo "  Desactivando Wayland..."
          echo ""
          sed -i -e 's-#WaylandEnable=false-WaylandEnable=false-g'  /etc/gdm3/custom.conf

          echo ""
          echo "  Reiniciando el sistema para aplicar los cambios..."
          echo ""
          echo "  Presiona ctrl + c para abortar el reinicio..."
          echo ""
          sleep 5
          shutdown -r now

        ;;

        2)

          echo ""
          echo "  Instalando x11vnc sin desactivar Wayland..."
          echo ""

          echo ""
          echo "  Actualizando el sistema..."
          echo ""
          apt-get -y update && apt-get -y upgrade

          echo ""
          echo "  Instalando el paquete x11vnc..."
          echo ""
          apt-get -y install x11vnc

          echo ""
          echo "  Instalando el paquete net-tools para poder utilizar netstat en -auth guess..."
          echo ""
          apt-get -y install net-tools

          echo ""
          echo "  Creando el servicio de systemd..."
          echo ""
          echo "[Unit]"                                                                                                                                            > /etc/systemd/system/x11vnc.service
          echo "Description=x11vnc service"                                                                                                                       >> /etc/systemd/system/x11vnc.service
          echo "After=display-manager.service network.target syslog.target"                                                                                       >> /etc/systemd/system/x11vnc.service
          echo ""                                                                                                                                                 >> /etc/systemd/system/x11vnc.service
          echo "[Service]"                                                                                                                                        >> /etc/systemd/system/x11vnc.service
          echo "Type=simple"                                                                                                                                      >> /etc/systemd/system/x11vnc.service
#         echo "ExecStart=/usr/bin/x11vnc -forever -display :0 -auth guess -passwd Pass123"                                                                       >> /etc/systemd/system/x11vnc.service
#         echo "ExecStart=/usr/bin/x11vnc -display :0 -forever -shared -rfbauth /etc/x11vnc.passwd"                                                               >> /etc/systemd/system/x11vnc.service
#         echo "ExecStart=/usr/bin/x11vnc -display :0 -auth guess -forever -loop -noxdamage -repeat -localhost -rfbauth /etc/x11vnc.passwd -rfbport 5900 -shared" >> /etc/systemd/system/x11vnc.service
          echo "ExecStart=/usr/bin/x11vnc -auth /run/user/1000/gdm/Xauthority -passwd Pass123"                                                               >> /etc/systemd/system/x11vnc.service
          echo "ExecStart=/usr/bin/x11vnc -auth /run/user/1000/gdm/Xauthority -rfbauth /etc/x11vnc.passwd"                                                               >> /etc/systemd/system/x11vnc.service
          echo "ExecStop=/usr/bin/killall x11vnc"                                                                                                                 >> /etc/systemd/system/x11vnc.service
          echo "Restart=on-failure"                                                                                                                               >> /etc/systemd/system/x11vnc.service
          echo ""                                                                                                                                                 >> /etc/systemd/system/x11vnc.service
          echo "[Install]"                                                                                                                                        >> /etc/systemd/system/x11vnc.service
          echo "WantedBy=multi-user.target"                                                                                                                       >> /etc/systemd/system/x11vnc.service

          echo ""
          echo "  Recargando la configuración de los daemons..."
          echo ""
          systemctl daemon-reload

          echo ""
          echo "  Activando e iniciando el servicio x11vnc..."
          echo ""
          systemctl enable x11vnc.service --now

          echo ""
          echo "  Creando contraseña de usuario para x11vnc..."
          echo ""
          x11vnc -storepasswd /etc/x11vnc.passwd
          chmod 0400 /etc/x11vnc.passwd

        ;;

        3)

          echo ""
          echo "  Opción 3..."
          echo ""

        ;;

        4)

          echo ""
          echo "  Opción 4..."
          echo ""

        ;;

        5)

          echo ""
          echo "  Opción 5..."
          echo ""

        ;;

    esac

  done

else

  echo ""
  echo -e "${vColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${vFinColor}"
  echo ""

fi

