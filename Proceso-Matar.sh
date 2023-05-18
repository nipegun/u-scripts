#!/bin/bash

if [[ "$1" =~ ^[0-9]+$ ]]; then # Si es número, matar el proceso por número
  pkill $1
else                            # Si no es número, matarlo por nombre
  killall -9 $1
fi
