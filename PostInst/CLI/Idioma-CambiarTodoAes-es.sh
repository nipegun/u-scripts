#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para cambiar el idioma del sistema y del teclado a sólo español
#
#  Ejecución remota (puede requerir permisos sudo):
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/CLI/Idioma-CambiarTodoAes-es.sh | bash
#
#  Ejecución remota como root (para sistemas sin sudo):
#  curl -s https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/PostInst/CLI/Idioma-CambiarTodoAes-es.sh | sed 's-sudo--g' | bash
# ----------

  # Poner que sólo se genere el español de España cuando se creen locales
    echo "es_ES.UTF-8 UTF-8" | sudo tee /etc/locale.gen

  # Compilar los locales borrando primero los existentes y dejando nada más que el español de España
    sudo apt-get -y update
    sudo apt-get -y install locales
    sudo locale-gen --purge es_ES.UTF-8

  # Modificar el archivo /etc/default/locale reflejando los cambios
    echo 'LANG="es_ES.UTF-8"'  | sudo tee    /etc/default/locale
    echo 'LANGUAGE="es_ES:es"' | sudo tee -a /etc/default/locale

  # Poner el teclado en español de España
    echo 'XKBMODEL="pc105"'  | sudo tee    /etc/default/keyboard
    echo 'XKBLAYOUT="es"'    | sudo tee -a /etc/default/keyboard
    echo 'XKBVARIANT=""'     | sudo tee -a /etc/default/keyboard
    echo 'XKBOPTIONS=""'     | sudo tee -a /etc/default/keyboard
    echo ''                  | sudo tee -a /etc/default/keyboard
    echo 'BACKSPACE="guess"' | sudo tee -a /etc/default/keyboard
    echo ''                  | sudo tee -a /etc/default/keyboard

  # Notificar cambios
    echo ""
    echo "  Cambios realizados.Debes reiniciar el sistema para que los cambios tengan efecto."
    echo ""

