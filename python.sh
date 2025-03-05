#!/bin/bash

# Atualizar os pacotes do sistema
sudo apt-get update

# Instalar dependências necessárias para construir a maioria dos pacotes Python
sudo apt-get install --no-install-recommends make build-essential libssl-dev \
zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y

# Verificar se o asdf já está instalado
if [ ! -d "$HOME/.asdf" ]; then
    echo "Instalando asdf..."
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
    echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
    echo '. $HOME/.asdf/asdf.sh' >> ~/.profile
fi

# Carregar asdf na sessão atual do script
source $HOME/.asdf/asdf.sh

# Adicionar o plugin do Python ao asdf, se ainda não estiver adicionado
if ! asdf plugin-list | grep -q python; then
    asdf plugin-add python
fi

# Definir a versão fixa do Python como 3.13.2
PYTHON_VERSION="3.13.2"

# Instalar e definir o Python 3.13.2 como versão global
asdf install python "$PYTHON_VERSION"
asdf global python "$PYTHON_VERSION"

# Configurar alias para python apontar para python3
echo 'alias python=python3' >> ~/.bashrc
source ~/.bashrc

echo "Instalação completa! Python $PYTHON_VERSION configurado como global."
