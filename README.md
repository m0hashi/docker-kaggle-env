# Docker image for Machine Learning on GPU Machine
This image is based on kaggle/python-image

## Prerquisite environment
- docker-compose
- nvidia-docker2

## Build 
```
./build
```

## RUN
```
./up
```

## Available Services/Ports
- juptyer:8879
- ssh: 22
- tensorboard: 6006
- mlflow: 500

## Shared volumes
- ./workspace 
- ~/.ssh
- ~/.kaggle
