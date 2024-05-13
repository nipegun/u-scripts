#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para poner los ventiladores de las tarjetas gráficas AMD al máximo
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/main/Hardware-Gr%C3%A1ficas-AMD-VentiladorAlMax.sh | bash
# ----------

# Número total de tarjetas gráficas
  vNumTarjGraf=$(ls /sys/class/drm/ | grep "card" | wc -l)

# Ajustar cada tarjeta
  for (( i=0; i<$vNumTarjGraf; i++ ))
    do
      echo "Estableciendo la velocidad del ventilador para la tarjeta $i"
      echo 1 > "/sys/class/drm/card$i/device/hwmon/hwmon$(($i))/pwm1_enable"
      echo 255 > "/sys/class/drm/card$i/device/hwmon/hwmon$(($i))/pwm1"
  done

