#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para cambiar el idioma del sistema y del teclado a sólo español
#
#  Ejecución remota:
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/main/PostInst/CLI/Idioma-CambiarTodoAes-es.sh | bash
# ----------

  # Poner que sólo se genere el español de España cuando se creen locales
    echo "es_ES.UTF-8 UTF-8" > /etc/locale.gen

  # Compilar los locales borrando primero los existentes y dejando nada más que el español de España
    apt-get -y update && apt-get -y install locales
    locale-gen --purge es_ES.UTF-8

  # Modificar el archivo /etc/default/locale reflejando los cambios
    echo 'LANG="es_ES.UTF-8"'   > /etc/default/locale
    echo 'LANGUAGE="es_ES:es"' >> /etc/default/locale

  # Poner el teclado en español de España
    echo 'XKBMODEL="pc105"'   > /etc/default/keyboard
    echo 'XKBLAYOUT="es"'    >> /etc/default/keyboard
    echo 'XKBVARIANT=""'     >> /etc/default/keyboard
    echo 'XKBOPTIONS=""'     >> /etc/default/keyboard
    echo ''                  >> /etc/default/keyboard
    echo 'BACKSPACE="guess"' >> /etc/default/keyboard
    echo ''                  >> /etc/default/keyboard

  # Notificar cambios
    echo ""
    echo "------------------------------------------------------------------"
    echo "  Cambios realizados."
    echo "  Debes reiniciar el sistema para que los cambios tengan efecto."
    echo "------------------------------------------------------------------"
    echo ""

