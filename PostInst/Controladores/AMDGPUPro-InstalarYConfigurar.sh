# Instalar
  curl -sL https://www.amd.com/es/support/linux-drivers
  #wget https://drivers.amd.com/drivers/linux/amdgpu-pro-20.40-1147286-ubuntu-20.04.tar.xz --referer https://www.amd.com/es/support/kb/release-notes/rn-amdgpu-unified-linux-20-40
  sudo chmod 777 amdgpu-install_xxx_all.deb
   sudo apt install amdgpu-install_xxx_all.deb
sudo apt-get update
  sudo amdgpu-install -y --accept-eula --usecase=opencl --opencl=rocr,legacy
#sudo usermod -a -G render $LOGNAME
sudo usermod -a -G render nipegun
#sudo usermod -a -G video $LOGNAME
sudo usermod -a -G video nipegun
sudo apt-get -y install clinfo

# Desinstalar
  sudo amdgpu-uninstall
  sudo apt-get -y purge amdgpu-install

