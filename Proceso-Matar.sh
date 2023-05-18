#!/bin/bash

if [[ "$1" =~ ^[0-9]+$ ]]; then # Si es número, matar el proceso por número
  echo ""
  echo "  Intentando matar el proceso por su n..."
  echo ""
  pkill $1
else                            # Si no es número, matarlo por nombre
  echo ""
  echo "  Intentando matar el proceso por su nombre..."
  echo ""
  killall -9 $1
  echo ""
fi
