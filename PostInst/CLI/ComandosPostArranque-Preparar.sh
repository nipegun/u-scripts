#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar los comandos postarranque en Ubuntu
#
# Ejecución remota (puede requerir permisos sudo):
#   curl -s https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/CLI/ComandosPostArranque-Preparar.sh | bash
#
# Ejecución remota como root (para sistemas sin sudo):
#   curl -s https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/CLI/ComandosPostArranque-Preparar.sh | sed 's-sudo--g' | bash
# ----------

vColorRojo='\033[1;31m'
vColorVerde='\033[1;32m'
vFinColor='\033[0m'

# Determinar la versión de Ubuntu
  vVersUbuntu=$(cat /etc/lsb-release | grep ODENAME | head -n1 | cut -d'=' -f2)

if [ $vVersUbuntu == "noble" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script para preparar los comandos post-arranque en Ubuntu 24.04 LTS (Noble Numbat)...${vFinColor}"
  echo ""

  echo ""
  echo "  Configurando el servicio..."
  echo ""
  echo '[Unit]'                                  | sudo tee    /etc/systemd/system/rc-local.service
  echo 'Description=/etc/rc.local Compatibility' | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'ConditionPathExists=/etc/rc.local'       | sudo tee -a /etc/systemd/system/rc-local.service
  echo ''                                        | sudo tee -a /etc/systemd/system/rc-local.service
  echo '[Service]'                               | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'Type=forking'                            | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'ExecStart=/etc/rc.local start'           | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'TimeoutSec=0'                            | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'StandardOutput=tty'                      | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'RemainAfterExit=yes'                     | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'SysVStartPriority=99'                    | sudo tee -a /etc/systemd/system/rc-local.service
  echo ''                                        | sudo tee -a /etc/systemd/system/rc-local.service
  echo '[Install]'                               | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'WantedBy=multi-user.target'              | sudo tee -a /etc/systemd/system/rc-local.service

  echo ""
  echo "  Creando el archivo /etc/rc.local..."
  echo ""
  echo '#!/bin/bash'                                          | sudo tee    /etc/rc.local
  echo ''                                                     | sudo tee -a /etc/rc.local
  echo '/root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh' | sudo tee -a /etc/rc.local
  echo 'exit 0'                                               | sudo tee -a /etc/rc.local
  sudo chmod +x /etc/rc.local

  echo ""
  echo "  Creando el archivo para meter los comandos..."
  echo ""
  sudo mkdir -p /root/scripts/ParaEsteUbuntu/ 2> /dev/null
  echo '#!/bin/bash'                                                                                                 | sudo tee    /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo 'vFechaDeEjec="$(date +A%YM%mD%d@%T)"'                                                                        | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo 'echo "Iniciada la ejecución del script post-arranque el $vFechaDeEjec" >> /var/log/ComandosPostArranque.log' | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo '#  ESCRIBE ABAJO, UNA POR LÍNEA, LAS TAREAS A EJECUTAR DESPUÉS DE CADA ARRANQUE'                             | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo '#▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼'                           | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  sudo chmod 700 /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  sudo touch /var/log/ComandosPostArranque.log

  echo ""
  echo "  Activando y arrancando el servicio..."
  echo ""
  sudo systemctl enable rc-local
  sudo systemctl start rc-local.service
  sudo systemctl status rc-local.service --no-pager

elif [ $vVersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script para preparar los comandos post-arranque en Ubuntu 22.04 LTS (Jammy Jellyfish)...${vFinColor}"
  echo ""

  echo ""
  echo "  Configurando el servicio..."
  echo ""
  echo '[Unit]'                                  | sudo tee    /etc/systemd/system/rc-local.service
  echo 'Description=/etc/rc.local Compatibility' | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'ConditionPathExists=/etc/rc.local'       | sudo tee -a /etc/systemd/system/rc-local.service
  echo ''                                        | sudo tee -a /etc/systemd/system/rc-local.service
  echo '[Service]'                               | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'Type=forking'                            | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'ExecStart=/etc/rc.local start'           | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'TimeoutSec=0'                            | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'StandardOutput=tty'                      | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'RemainAfterExit=yes'                     | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'SysVStartPriority=99'                    | sudo tee -a /etc/systemd/system/rc-local.service
  echo ''                                        | sudo tee -a /etc/systemd/system/rc-local.service
  echo '[Install]'                               | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'WantedBy=multi-user.target'              | sudo tee -a /etc/systemd/system/rc-local.service

  echo ""
  echo "  Creando el archivo /etc/rc.local..."
  echo ""
  echo '#!/bin/bash'                                          | sudo tee    /etc/rc.local
  echo ''                                                     | sudo tee -a /etc/rc.local
  echo '/root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh' | sudo tee -a /etc/rc.local
  echo 'exit 0'                                               | sudo tee -a /etc/rc.local
  sudo chmod +x /etc/rc.local

  echo ""
  echo "  Creando el archivo para meter los comandos..."
  echo ""
  sudo mkdir -p /root/scripts/ParaEsteUbuntu/ 2> /dev/null
  echo '#!/bin/bash'                                                                                                 | sudo tee    /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo 'vFechaDeEjec="$(date +A%YM%mD%d@%T)"'                                                                        | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo 'echo "Iniciada la ejecución del script post-arranque el $vFechaDeEjec" >> /var/log/ComandosPostArranque.log' | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo '#  ESCRIBE ABAJO, UNA POR LÍNEA, LAS TAREAS A EJECUTAR DESPUÉS DE CADA ARRANQUE'                             | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo '#▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼'                           | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  sudo chmod 700 /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  sudo touch /var/log/ComandosPostArranque.log

  echo ""
  echo "  Activando y arrancando el servicio..."
  echo ""
  sudo systemctl enable rc-local
  sudo systemctl start rc-local.service
  sudo systemctl status rc-local.service --no-pager

elif [ $vVersUbuntu == "focal" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script para preparar los comandos post-arranque en Ubuntu 20.04 LTS (Focal Fossa)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 20.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $vVersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script para preparar los comandos post-arranque en Ubuntu 18.04 LTS (Bionic Beaver)...${vFinColor}"
  echo ""
  echo ""
  echo "  Configurando el servicio..."
  echo ""
  echo '[Unit]'                                  | sudo tee    /etc/systemd/system/rc-local.service
  echo 'Description=/etc/rc.local Compatibility' | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'ConditionPathExists=/etc/rc.local'       | sudo tee -a /etc/systemd/system/rc-local.service
  echo ''                                        | sudo tee -a /etc/systemd/system/rc-local.service
  echo '[Service]'                               | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'Type=forking'                            | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'ExecStart=/etc/rc.local start'           | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'TimeoutSec=0'                            | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'StandardOutput=tty'                      | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'RemainAfterExit=yes'                     | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'SysVStartPriority=99'                    | sudo tee -a /etc/systemd/system/rc-local.service
  echo ''                                        | sudo tee -a /etc/systemd/system/rc-local.service
  echo '[Install]'                               | sudo tee -a /etc/systemd/system/rc-local.service
  echo 'WantedBy=multi-user.target'              | sudo tee -a /etc/systemd/system/rc-local.service

  echo ""
  echo "  Creando el archivo /etc/rc.local..."
  echo ""
  echo '#!/bin/bash'                                          | sudo tee    /etc/rc.local
  echo ''                                                     | sudo tee -a /etc/rc.local
  echo '/root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh' | sudo tee -a /etc/rc.local
  echo 'exit 0'                                               | sudo tee -a /etc/rc.local
  sudo chmod +x /etc/rc.local

  echo ""
  echo "  Creando el archivo para meter los comandos..."
  echo ""
  sudo mkdir -p /root/scripts/ParaEsteUbuntu/ 2> /dev/null
  echo '#!/bin/bash'                                                                                                 | sudo tee    /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo 'vFechaDeEjec="$(date +A%YM%mD%d@%T)"'                                                                        | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo 'echo "Iniciada la ejecución del script post-arranque el $vFechaDeEjec" >> /var/log/ComandosPostArranque.log' | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo '#  ESCRIBE ABAJO, UNA POR LÍNEA, LAS TAREAS A EJECUTAR DESPUÉS DE CADA ARRANQUE'                             | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo '#▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼'                           | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  echo ''                                                                                                            | sudo tee -a /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  sudo chmod 700 /root/scripts/ParaEsteUbuntu/ComandosPostArranque.sh
  sudo touch /var/log/ComandosPostArranque.log

  echo ""
  echo "  Activando y arrancando el servicio..."
  echo ""
  sudo systemctl enable rc-local
  sudo systemctl start rc-local.service
  sudo systemctl status rc-local.service --no-pager

elif [ $vVersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script para preparar los comandos post-arranque en Ubuntu 16.04 LTS (Xenial Xerus)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 16.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $vVersUbuntu == "trusty" ]; then

  echo ""
  echo -e "${vColorVerde}  Iniciando el script para preparar los comandos post-arranque en Ubuntu 14.04 LTS (Trusty Tahr)...${vFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

else

  echo ""
  echo -e "${vColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${vFinColor}"
  echo ""

fi

