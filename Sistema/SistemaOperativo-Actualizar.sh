#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para actualizar Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/Sistema/SistemaOperativo-Actualizar.sh | bash
# ----------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

echo ""
echo -e "${ColorVerde}  Iniciando el script de actualización de Ubuntu...${FinColor}"
echo ""

echo ""
echo "  Reparando permisos de la carpeta /tmp/ ...$"
echo ""
sudo chmod 1777 /tmp

echo ""
echo "  Ejecutando apt-get update..."
echo ""
sudo apt-get -y update

echo ""
echo "  Ejecutando apt-get -y upgrade..."
echo ""
sudo apt-get -y --allow-downgrades upgrade

echo ""
echo "  Ejecutando apt-get -y dist-upgrade..."
echo ""
sudo apt-get -y --allow-downgrades dist-upgrade

echo ""
echo "  Ejecutando apt-get -y autoremove..."
echo ""
sudo apt-get -y autoremove

echo ""
echo -e "${ColorVerde}  Script para actualizar el sistema operativo, finalizado.${FinColor}"
echo ""

