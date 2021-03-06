#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#---------------------------------------------------------------------------------------------------------------------------------------------
#  Script de NiPeGun para instalar y configurar las Guest Additions en una máquina vritual Virtual Box de Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/SoftInst/Consola/VirtualBoxGuestAdditions-InstalarEnMVdeUbuntu.sh | bash
#---------------------------------------------------------------------------------------------------------------------------------------------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

## Determinar la versión de Ubuntu
   VersUbuntu=$(cat /etc/lsb-release | grep ODENAME | head -n1 | cut -d'=' -f2)

if [ $VersUbuntu == "trusty" ]; then

  echo ""
  echo -e "${ColorVerde}  Iniciando el script de instalación de las Guest Additions para una MV de Ubuntu 14.04 LTS (Trusty Tahr)...${FinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $VersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${ColorVerde}  Iniciando el script de instalación de las Guest Additions para una MV de Ubuntu 16.04 LTS (Xenial Xerus)...${FinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 16.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $VersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${ColorVerde}  Iniciando el script de instalación de las Guest Additions para una MV de Ubuntu 18.04 LTS (Bionic Beaver)...${FinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 18.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $VersUbuntu == "focal" ]; then

  echo ""
  echo -e "${ColorVerde}  Iniciando el script de instalación de las Guest Additions para una MV de Ubuntu 20.04 LTS (Focal Fossa)...${FinColor}"
  echo ""

  ## Instalar dependencias
     sudo apt-get -y update
     sudo apt-get -y install build-essential

  ## Determinar el usuario que está ejecutando el script
     UsuarioActual=$(whoami)

  ## Desmontar el DVD virtual
     umount /dev/sr0 

  ## Montarlo nuevamente en la carpeta deseada
     mkdir -p /home/$UsuarioActual/vboxguestadditions/ 2> /dev/null
     sudo mount /dev/sr0 /home/$UsuarioActual/vboxguestadditions/

  ## Instalar las extensiones del huésped
     sudo sh /home/$UsuarioActual/vboxguestadditions/autorun.sh

  ## Reiniciar el sistema
     #sudo shutdown -r now

elif [ $VersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${ColorVerde}  Iniciando el script de instalación de las Guest Additions para una MV de Ubuntu 22.04 LTS (Jammy Jellyfish)...${FinColor}"
  echo ""

  ## Instalar dependencias
     sudo apt-get -y update
     sudo apt-get -y install build-essential

  ## Determinar el usuario que está ejecutando el script
     UsuarioActual=$(whoami)

  ## Desmontar el DVD virtual
     umount /dev/sr0 

  ## Montarlo nuevamente en la carpeta deseada
     mkdir -p /home/$UsuarioActual/vboxguestadditions/ 2> /dev/null
     sudo mount /dev/sr0 /home/$UsuarioActual/vboxguestadditions/

  ## Instalar las extensiones del huésped
     sudo sh /home/$UsuarioActual/vboxguestadditions/autorun.sh

  ## Reiniciar el sistema
     #sudo shutdown -r now

else

  echo ""
  echo -e "${ColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${FinColor}"
  echo ""

fi

