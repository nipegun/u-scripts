#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
# Script de NiPeGun para poner los ventiladores de las tarjetas gráficas AMD al máximo
#
# Ejecución remota:
#   curl -sL https://raw.githubusercontent.com/nipegun/u-scripts/refs/heads/main/Sistema/Hardware-Gr%C3%A1ficas-AMD-VentiladorAlMax.sh | sudo bash
# ----------

# Número total de tarjetas gráficas
  vNumTarjGraf=$(ls /sys/class/drm/ | grep "card" | wc -l)

# Ajustar cada tarjeta
  for (( i=0; i<$vNumTarjGraf; i++ ))
    do
      if [ -f "/sys/class/drm/card$i/device/hwmon/hwmon$(($i))/pwm1_enable" ]; then
        echo ""
        echo "  Desactivando el modo PWM de los ventiladores de la tarjeta $i..."
        echo ""
        echo 1 > "/sys/class/drm/card$i/device/hwmon/hwmon$(($i))/pwm1_enable"
      fi
      if [ -f "/sys/class/drm/card$i/device/hwmon/hwmon$(($i))/pwm1" ]; then
        echo ""
        echo "  Asignando máximas revoluciones a los ventiladores e la tarjeta $i..."
        echo ""
        echo 255 > "/sys/class/drm/card$i/device/hwmon/hwmon$(($i))/pwm1"
      fi

  done

