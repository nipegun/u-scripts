#!/bin/bash

sudo cp /etc/default/grub /etc/default/grub.bak
sudo sed -i -e 's|^GRUB_TIMEOUT_STYLE=.*|GRUB_DISABLE_OS_PROBER=false"|g' /etc/default/grub
sudo sed -i -e 's|^GRUB_TIMEOUT=.*|GRUB_TIMEOUT=2|g'                      /etc/default/grub
sudo update-grub

