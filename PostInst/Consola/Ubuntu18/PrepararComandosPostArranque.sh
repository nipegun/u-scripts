#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#-----------------------------------------------------------------
#  Script de NiPeGun para activar rc.local en Ubuntu con SystemD
#-----------------------------------------------------------------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

echo ""
echo -e "${ColorVerde}Configurando el servicio...${FinColor}"
echo ""
sudo su -c 'echo "[Unit]" > /etc/systemd/system/rc-local.service'
sudo su -c 'echo "Description=/etc/rc.local Compatibility" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "ConditionPathExists=/etc/rc.local" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "[Service]" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "Type=forking" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "ExecStart=/etc/rc.local start" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "TimeoutSec=0" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "StandardOutput=tty" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "RemainAfterExit=yes" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "SysVStartPriority=99" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "[Install]" >> /etc/systemd/system/rc-local.service'
sudo su -c 'echo "WantedBy=multi-user.target" >> /etc/systemd/system/rc-local.service'

echo ""
echo -e "${ColorVerde}Creando el archivo /etc/rc.local ...${FinColor}"
echo ""
sudo su -c "echo '#!/bin/bash' > /etc/rc.local"
sudo su -c 'echo "" >> /etc/rc.local'
sudo su -c 'echo "/root/scripts/ComandosPostArranque.sh" >> /etc/rc.local'
sudo su -c 'echo "exit 0" >> /etc/rc.local'
sudo chmod +x /etc/rc.local

echo ""
echo -e "${ColorVerde}Creando el archivo para meter los comandos...${FinColor}"
echo ""
sudo mkdir -p /root/scripts/ 2> /dev/null
sudo su -c "echo '#!/bin/bash' > /root/scripts/ComandosPostArranque.sh"
sudo su -c 'echo "" >> /root/scripts/ComandosPostArranque.sh'
sudo su -c 'echo "" >> /root/scripts/ComandosPostArranque.sh'
sudo su -c "echo "FechaDeEjec='$(date +A%YM%mD%d@%T)'" >> /root/scripts/ComandosPostArranque.sh"
sudo su -c 'echo "" >> /root/scripts/ComandosPostArranque.sh'
sudo su -c 'echo 'echo "Iniciada la ejecución del script post-arranque el $FechaDeEjec" >> /var/log/PostArranque.log' >> /root/scripts/ComandosPostArranque.sh'
sudo su -c 'echo "" >> /root/scripts/ComandosPostArranque.sh'
sudo su -c 'echo "#  ESCRIBE ABAJO, UNA POR LÍNEA, LAS TAREAS A EJECUTAR DESPUÉS DE CADA ARRANQUE"  >> /root/scripts/ComandosPostArranque.sh'
sudo su -c 'echo "#▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼" >> /root/scripts/ComandosPostArranque.sh'
sudo su -c 'echo "" >> /root/scripts/ComandosPostArranque.sh'
sudo chmod 700 /root/scripts/ComandosPostArranque.sh

echo ""
echo -e "${ColorVerde}Activando y arrancando el servicio...${FinColor}"
echo ""
#sudo systemctl enable rc-local
#sudo systemctl start rc-local.service
#sudo systemctl status rc-local.service

