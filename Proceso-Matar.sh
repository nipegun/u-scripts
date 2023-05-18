#!/bin/bash

if [[ "$1" =~ ^[0-9]+$ ]]; then # Si es número, matar el proceso por número
  echo ""
  echo "  Intentando matar el proceso por su n..."
  echo ""
  pkill $1
else                            # Si no es número, matarlo por nombre
  echo ""
  echo "  Intentando matar el proceso $1 por su nombre..."
  echo ""
  
  echo "    Buscando el número de proceso del software $1..."
  vNumProceso=$(pgrep -n notepadqq)
  
  echo ""
  echo "      El número de proceso es: $vNumProceso"
  kill $vNumProceso
  
  echo "        Intentando matar el proceso $vNumProceso por su nombre..."
  echo ""
  
fi
