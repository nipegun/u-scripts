#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para instalar y configurar GitLabCE en Ubuntu
#
# Ejecución remota (puede requerir permisos sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/GitLabCE-InstalarYConfigurar.sh | bash
#
# Ejecución remota como root (para sistemas sin sudo):
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/GitLabCE-InstalarYConfigurar.sh | sed 's-sudo--g' | bash
#
# Bajar y editar directamente el archivo en nano
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/SoftInst/ServWeb/GitLabCE-InstalarYConfigurar.sh | nano -
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
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de GitLabCE para Ubuntu 24.04 LTS (Noble Numbat)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 24.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "jammy" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de GitLabCE para Ubuntu 22.04 LTS (Jammy Jellyfish)...${cFinColor}"
  echo ""

  # Actualizar el sistema
    sudo apt-get -y update
    sudo apt-get -y upgrade

  # Instalar paquetes necesarios
    sudo apt-get -y install curl
    sudo apt-get -y install ca-certificates
    sudo apt-get -y install gnupg2
    sudo apt-get -y install lsb-release

  # Instalar postfix para el sistema de mails
    sudo apt-get -y install postfix

  # Añadir el repo
    curl -fsSL https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
    # Cambiar repo trixie por bookworm (temporal haasta que haya uno oficial)
      sudo sed -i 's-trixie-bookworm-g' /etc/apt/sources.list.d/gitlab_gitlab-ce.list
    # Actualizar lista de paquetes del repo
      sudo apt-get -y update

  # Instlar paquete principal
    sudo apt-get -y install gitlab-ce

  # Configurar el DNS
    echo "127.0.0.1 $vFQDNGitLab" | sudo tee -a /etc/hosts
    #sed -i -e "s|external_url 'http://gitlab.example.com'|'http://gitlab.example.com'|g" /etc/gitlab/gitlab.rb

  # Reconfigurar gitlab
    sudo gitlab-ctl reconfigure

  # Poner en español
    sudo sed -i 's|config.i18n.fallbacks = [:en]|config.i18n.fallbacks = [:es]|g' /opt/gitlab/embedded/service/gitlab-rails/config/application.rb

  # Notificar password
    echo ""
    echo "    Para loguearte usa el usuario root y el password que está en el archivo /etc/gitlab/initial_root_password."
    echo ""
    echo "    Mostrando el contenido del archivo /etc/gitlab/initial_root_password..."
    echo ""
    sudo cat /etc/gitlab/initial_root_password

  # Notificar fin de ejecución del script
    echo ""
    echo "    Ejecución del script, finalizada."
    echo ""
    vIPLocal=$(hostname -I | sed 's- --g' )
    echo "      Para acceder a la web:"
    echo ""
    echo "        http://$vIPLocal:80"
    echo ""
    echo "          o"
    echo ""
    echo "        http://$vIPLocal:443"
    echo ""
    echo "      Para desactivar la recolección y el envío de eventos a la gente de GitLab:"
    echo ""
    echo "        - Despliega la barra lateral izquierda (si no estña desplegada) y abajo a la derecha haz click en Admin"
    echo "        - Pasa el ratón por Settings y haz click en Metrics and profiling."
    echo "        - Expande Event tracking, deselecciona Enable event tracking y haz clock en el botón Save changes."
    echo ""
    echo "      Para cambiar la web de puerto hay que modificar el archivo /etc/gitlab/gitlab.rb"
    echo "        y cambiar external_url 'http://gitlab.ejemplo.com por external_url 'https://gitlab.ejemplo.com:8443"
    echo ""
    echo "      Para cambiar ajustes de localización: Admin > Settings > Preferences > Localization"
    echo ""

elif [ $cVersUbuntu == "focal" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de GitLabCE para Ubuntu 20.04 LTS (Focal Fossa)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 20.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "bionic" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de GitLabCE para Ubuntu 18.04 LTS (Bionic Beaver)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 18.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "xenial" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de GitLabCE para Ubuntu 16.04 LTS (Xenial Xerus)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 16.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

elif [ $cVersUbuntu == "trusty" ]; then

  echo ""
  echo -e "${cColorAzulClaro}  Iniciando el script de instalación de GitLabCE para Ubuntu 14.04 LTS (Trusty Tahr)...${cFinColor}"
  echo ""

  echo ""
  echo "  Comandos para Ubuntu 14.04 LTS todavía no preparados. Prueba ejecutarlo en otra versión de Ubuntu."
  echo ""

else

  echo ""
  echo -e "${cColorRojo}  Los u-scripts no se pueden ejecutar en versiones de Ubuntu que no sean LTS...${cFinColor}"
  echo ""

fi
