
#!/bin/bash
if ! command -v docker &> /dev/null
then
  https://get.docker.com | sh && sudo systemctl --now enable docker
fi

if ! command -v nvidia-container-toolkit  &> /dev/null
then
  curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list  
  &&  sudo apt update
  sudo apt install -y nvidia-container-toolkit

  # dnf
  curl -s -L https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo | \
  sudo tee /etc/yum.repos.d/nvidia-container-toolkit.repo
  sudo dnf install -y nvidia-container-toolkit
  
  sudo nvidia-ctk runtime configure --runtime=docker --set-as-default
  sudo systemctl restart docker
fi
