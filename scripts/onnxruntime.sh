#!/bin/bash
ONNXRUNTIME_VERSION=1.16.0
cd /tmp
wget https://github.com/microsoft/onnxruntime/releases/download/v${ONNXRUNTIME_VERSION}/onnxruntime-linux-x64-gpu-${ONNXRUNTIME_VERSION}.tgz
sudo tar xvf onnxruntime-linux-x64-gpu-${ONNXRUNTIME_VERSION}.tgz -C /opt
sudo ln -s /opt/onnxruntime-linux-x64-gpu-${ONNXRUNTIME_VERSION} /opt/onnxruntime
sudo rm onnxruntime-linux-x64-gpu-${ONNXRUNTIME_VERSION}.tgz
