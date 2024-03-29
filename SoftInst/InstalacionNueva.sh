#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar xxxxxxxxx en Ubuntu
#
#  Ejecución remota:
#  curl -s x | bash
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

  echo ""
  echo "  Comandos para Ubuntu 22.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

else

  echo ""
  echo -e "${vColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${vFinColor}"
  echo ""

fi

