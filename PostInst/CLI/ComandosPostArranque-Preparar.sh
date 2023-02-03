#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar los comandos postarranque en Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/PostInst/CLI/ComandosPostArranque-Preparar.sh | bash
# ----------

vColorRojo='\033[1;31m'
vColorVerde='\033[1;32m'
vFinColor='\033[0m'

# Determinar la versión de Ubuntu
  vVersUbuntu=$(cat /etc/lsb-release | grep ODENAME | head -n1 | cut -d'=' -f2)

if [ $vVersUbuntu == "trusty" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 14.04 LTS (Trusty Tahr)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $vVersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 16.04 LTS (Xenial Xerus)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 16.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $vVersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 18.04 LTS (Bionic Beaver)...${vFinColor}"
  echo ""

  echo ""
  echo "  Configurando el servicio..."
  echo ""
  sudo su -c 'echo "[Unit]"                                   > /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "Description=/etc/rc.local Compatibility" >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "ConditionPathExists=/etc/rc.local"       >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo ""                                        >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "[Service]"                               >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "Type=forking"                            >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "ExecStart=/etc/rc.local start"           >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "TimeoutSec=0"                            >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "StandardOutput=tty"                      >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "RemainAfterExit=yes"                     >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "SysVStartPriority=99"                    >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo ""                                        >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "[Install]"                               >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "WantedBy=multi-user.target"              >> /etc/systemd/system/rc-local.service'

  echo ""
  echo "  Creando el archivo /etc/rc.local..."
  echo ""
  sudo su -c "echo '#!/bin/bash'                            > /etc/rc.local"
  sudo su -c 'echo ""                                      >> /etc/rc.local'
  sudo su -c 'echo "/root/scripts/ComandosPostArranque.sh" >> /etc/rc.local'
  sudo su -c 'echo "exit 0"                                >> /etc/rc.local'
  sudo chmod +x /etc/rc.local

  echo ""
  echo "  Creando el archivo para meter los comandos..."
  echo ""
  sudo mkdir -p /root/scripts/ 2> /dev/null
  sudo su -c "echo '#!/bin/bash'                                                                                          > /root/scripts/ComandosPostArranque.sh"
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c "echo 'vFechaDeEjec="'$(date +A%YM%mD%d@%T)'"'                                                              >> /root/scripts/ComandosPostArranque.sh"
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo 'echo "Iniciada la ejecución del script post-arranque el $vFechaDeEjec" >> /var/log/PostArranque.log' >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo "#  ESCRIBE ABAJO, UNA POR LÍNEA, LAS TAREAS A EJECUTAR DESPUÉS DE CADA ARRANQUE"                     >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo "#▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼"                   >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo chmod 700 /root/scripts/ComandosPostArranque.sh
  sudo touch /var/log/PostArranque.log

  echo ""
  echo "  Activando y arrancando el servicio..."
  echo ""
  sudo systemctl enable rc-local
  sudo systemctl start rc-local.service
  sudo systemctl status rc-local.service

elif [ $vVersUbuntu == "focal" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 20.04 LTS (Focal Fossa)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 20.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $VersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script de instalación de xxxxxxxxx para Ubuntu 22.04 LTS (Jammy Jellyfish)...${vFinColor}"
  echo ""

  echo ""
  echo "  Configurando el servicio..."
  echo ""
  sudo su -c 'echo "[Unit]"                                   > /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "Description=/etc/rc.local Compatibility" >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "ConditionPathExists=/etc/rc.local"       >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo ""                                        >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "[Service]"                               >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "Type=forking"                            >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "ExecStart=/etc/rc.local start"           >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "TimeoutSec=0"                            >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "StandardOutput=tty"                      >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "RemainAfterExit=yes"                     >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "SysVStartPriority=99"                    >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo ""                                        >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "[Install]"                               >> /etc/systemd/system/rc-local.service'
  sudo su -c 'echo "WantedBy=multi-user.target"              >> /etc/systemd/system/rc-local.service'

  echo ""
  echo "  Creando el archivo /etc/rc.local..."
  echo ""
  sudo su -c "echo '#!/bin/bash'                            > /etc/rc.local"
  sudo su -c 'echo ""                                      >> /etc/rc.local'
  sudo su -c 'echo "/root/scripts/ComandosPostArranque.sh" >> /etc/rc.local'
  sudo su -c 'echo "exit 0"                                >> /etc/rc.local'
  sudo chmod +x /etc/rc.local

  echo ""
  echo "  Creando el archivo para meter los comandos..."
  echo ""
  sudo mkdir -p /root/scripts/ 2> /dev/null
  sudo su -c "echo '#!/bin/bash'                                                                                          > /root/scripts/ComandosPostArranque.sh"
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c "echo 'vFechaDeEjec="'$(date +A%YM%mD%d@%T)'"'                                                              >> /root/scripts/ComandosPostArranque.sh"
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo 'echo "Iniciada la ejecución del script post-arranque el $vFechaDeEjec" >> /var/log/PostArranque.log' >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo "#  ESCRIBE ABAJO, UNA POR LÍNEA, LAS TAREAS A EJECUTAR DESPUÉS DE CADA ARRANQUE"                     >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo "#▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼"                   >> /root/scripts/ComandosPostArranque.sh'
  sudo su -c 'echo ""                                                                                                    >> /root/scripts/ComandosPostArranque.sh'
  sudo chmod 700 /root/scripts/ComandosPostArranque.sh
  sudo touch /var/log/PostArranque.log

  echo ""
  echo "  Activando y arrancando el servicio..."
  echo ""
  sudo systemctl enable rc-local
  sudo systemctl start rc-local.service
  sudo systemctl status rc-local.service

else

  echo ""
  echo -e "${vColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${vFinColor}"
  echo ""

fi

