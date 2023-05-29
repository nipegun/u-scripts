#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

# ----------
#  Script de NiPeGun para crear los alias de los u-scripts 
# ----------

# Definir variables de color
  vColorAzul="\033[0;34m"
  vColorAzulClaro="\033[1;34m"
  vColorVerde='\033[1;32m'
  vColorRojo='\033[1;31m'
  vFinColor='\033[0m'

echo ""
echo -e "${vColorAzulClaro}  Creando alias para los u-scripts...${vFinColor}"
echo ""

ln -s ~/scripts/u-scripts/SistemaOperativo-Actualizar.sh            ~/scripts/u-scripts/Alias/aso
ln -s ~/scripts/u-scripts/SistemaOperativo-ActualizarYApagar.sh     ~/scripts/u-scripts/Alias/asoya
ln -s ~/scripts/u-scripts/SistemaOperativo-ActualizarYReiniciar.sh  ~/scripts/u-scripts/Alias/asoyr
ln -s ~/scripts/u-scripts/SistemaOperativo-Apagar.sh                ~/scripts/u-scripts/Alias/apso
ln -s ~/scripts/u-scripts/SistemaOperativo-Reiniciar.sh             ~/scripts/u-scripts/Alias/rso

ln -s ~/scripts/u-scripts/UScripts-Sincronizar.sh                    ~/scripts/u-scripts/Alias/sinus

echo ""
echo -e "${vColorVerde}    Alias creados. Deberías poder ejecutar los u-scripts escribiendo el nombre de su alias.${vFinColor}"
echo ""

