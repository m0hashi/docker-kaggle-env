#!/bin/bash
set -eux

#-------------------------------------------------------------------------------
#References
#-------------------------------------------------------------------------------
#https://matsuand.github.io/docs.docker.jp.onthefly/compose/gpu-support/
#https://matsuand.github.io/docs.docker.jp.onthefly/config/containers/resource_constraints/#gpu
#https://nvidia.github.io/nvidia-container-runtime/

#-------------------------------------------------------------------------------
#Install NVIDIA Container runtime
#-------------------------------------------------------------------------------
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update
sudo apt-get install -y nvidia-container-runtime

