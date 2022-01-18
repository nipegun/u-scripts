#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#--------------------------------------------------------------------------------------------------------
#  Script de NiPeGun para activar la cuenta del root en Ubuntu
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/Usuarios-root-ActivarCuenta.sh | bash
#--------------------------------------------------------------------------------------------------------

## Agregarle una constraseña a la cuenta del root
   echo ""
   echo "  Desactivando la cuenta del root..."
   echo ""
   sudo passwd root

## Notificar finalización de script
   echo ""
   echo "  Script finalizado..."
   echo ""
   echo "  No deberías poder loguearte con el root..."
   echo ""

