#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para cambiar el nombre de un usuario
#
#  Ejecución con curl:
#  sudo curl --silent https://raw.githubusercontent.com/nipegun/u-scripts/main/Usuario-CambiarNombre.sh | bash -s UsuarioViejo UsuarioNuevo
# ----------

CantArgsCorrectos=2
ArgsInsuficientes=65

if [ $# -ne $CantArgsCorrectos ]
  then
    echo ""
    echo "------------------------------------------------------------------------------"
    echo "Mal uso del script."
    echo ""
    echo "El uso correcto sería: cndu [NombreDeUsuarioViejo] [NombreDeUsuarioNuevo]"
    echo ""
    echo "Ejemplo:"
    echo ' cndu pepe jose'
    echo "------------------------------------------------------------------------------"
    echo ""
    exit $ArgsInsuficientes
  else
    echo ""
    sudo usermod -l $2 $1
    sudo usermod -d /home/$2 -m $2
    sudo groupmod -n $2 $1
    echo ""
fi
