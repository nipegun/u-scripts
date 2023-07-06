curl -sL https://www.amd.com/es/support/linux-drivers
sudo chmod 777 amdgpu-install_xxx_all.deb
sudo apt install amdgpu-install_xxx_all.deb
sudo apt-get update
sudo amdgpu-install -y --accept-eula --usecase=opencl --opencl=rocr,legacy
#sudo usermod -a -G render $LOGNAME
sudo usermod -a -G render nipegun
#sudo usermod -a -G video $LOGNAME
sudo usermod -a -G video nipegun
sudo apt-get -y install clinfo

