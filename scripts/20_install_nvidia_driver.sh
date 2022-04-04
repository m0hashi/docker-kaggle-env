#!/bin/bash

#-------------------------------------------------------------------------------
# NVIDIA Driver install
# nvidia-driver-xxx でなくcuda-driverをインストールする方法が推奨されている
# 
# 参考)
# https://github.com/NVIDIA/nvidia-docker/wiki/Frequently-Asked-Questions#how-do-i-install-the-nvidia-driver
# How do I install the NVIDIA driver?
# 
# The recommended way is to use your package manager and install the cuda-drivers package (or equivalent).
# When no packages are available, you should use an official "runfile".
# 
# Alternatively, the NVIDIA driver can be deployed through a container.
# Refer to the documentation for more information.
# 
# 参考)
# https://medium.com/nvidiajapan/nvidia-docker-%E3%81%A3%E3%81%A6%E4%BB%8A%E3%81%A9%E3%81%86%E3%81%AA%E3%81%A3%E3%81%A6%E3%82%8B%E3%81%AE-20-09-%E7%89%88-558fae883f44
#-------------------------------------------------------------------------------
sudo apt update

#-------------------------------------------------------------------------------
# 下記Cuda ToolkitのWebサイトで自身のディストリビューションを選択
# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_network
# 
#-------------------------------------------------------------------------------

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update 
sudo apt-get -y install cuda-drivers
