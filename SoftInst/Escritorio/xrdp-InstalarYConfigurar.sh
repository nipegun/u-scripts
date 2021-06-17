          echo ""
          echo "------------------------------------------------------------------"
          echo "  Instalando y preparando el escritorio remoto para Ubuntu 18.04"
          echo "------------------------------------------------------------------"
          echo ""
          # Instalar Gnome Tweak Tool
          sudo apt-get -y install gnome-tweak-tool
          # Permitir el acceso a la consola
          sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
          # Crear políticas de excepción
          echo "[Allow Colord all Users]" > /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
          echo "Identity=unix-user:*" >> /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
          echo "Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile" >> /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
          echo "ResultAny=no" >> /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
          echo "ResultInactive=no" >> /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
          echo "ResultActive=yes" >> /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla
          # Activar las extensiones de Gnome Shell
          gnome-shell-extension-tool -e ubuntu-dock@ubuntu.com
          gnome-shell-extension-tool -e ubuntu-appindicators@ubuntu.com
          # Vaciar la carpeta de crashes
          sudo rm /var/crash/*
