#!/bin/bash

# Atualizar os pacotes do sistema
echo "Atualizando o sistema..."
sudo apt-get update
sudo apt-get upgrade -y

# Instalar dependências necessárias
echo "Instalando dependências necessárias..."
sudo apt-get install --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

# Adicionar a chave GPG do repositório do Docker
echo "Adicionando a chave GPG do Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adicionar o repositório do Docker para ARM64
echo "Adicionando o repositório do Docker..."
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizar a lista de pacotes novamente
echo "Atualizando a lista de pacotes com o repositório do Docker..."
sudo apt-get update

# Instalar o Docker
echo "Instalando o Docker..."
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# Verificar a instalação
echo "Verificando a versão do Docker instalada..."
docker --version

# Configurar permissões (opcional) para usar o Docker sem sudo
echo "Configurando permissões para o usuário atual (opcional)..."
sudo usermod -aG docker $USER
newgrp docker

echo "Instalação do Docker concluída com sucesso!"
