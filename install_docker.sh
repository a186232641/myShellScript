#!/bin/bash

# 检查是否以root权限运行
if [ "$EUID" -ne 0 ]
  then echo "请以root权限运行此脚本"
  exit
fi

# 更新系统包列表
apt update

# 安装必要的依赖包
apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# 添加Docker的官方GPG密钥
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 设置稳定版仓库
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# 再次更新包列表
apt update

# 安装Docker Engine
apt install -y docker-ce docker-ce-cli containerd.io

# 验证安装
docker run hello-world

# 将当前用户添加到docker组
usermod -aG docker $USER

echo "Docker安装完成。请注销并重新登录以应用组更改。"
