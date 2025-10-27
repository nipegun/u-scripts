#/bin/bash

/usr/bin/x11vnc -auth /run/user/$(id -u $(whoami))/gdm/Xauthority -noxdamage -forever

