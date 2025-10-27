#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para activar la cuenta del root en Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/Sistema/Usuarios-root-ActivarCuenta.sh | bash
# ----------

# Agregarle una constraseña a la cuenta del root para poder loguearse por cli
  echo ""
  echo "  Agregando una contraseña al usuario root..."
  echo ""
  sudo passwd root

# Habilitar el root en la configuración de Gnome Display Manager
  echo ""
  echo "  Modificando el archivo de configuración de Gnome Display Manager..."
  echo ""
  sed -i -e 's|\[security]|\[security]\nAllowRoot=true|g' /etc/gdm3/custom.conf

# Modificar /etc/pam.d/gdm-password
  echo ""
  echo "  Modificando /etc/pam.d/gdm-password..."
  echo ""
  sed -i '/root quiet_success/c\#auth required pam_succeed_if.so user != root quiet_success' /etc/pam.d/gdm-password

# Notificar finalización de script
  echo ""
  echo "  Script finalizado..."
  echo ""
  echo "  Ya deberías poder loguearte con el root..."
  echo ""

