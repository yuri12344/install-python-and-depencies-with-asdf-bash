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
    echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc
    source ~/.bashrc
else
    echo "asdf já está instalado."
fi

# Adicionar o plugin do Python ao asdf, se ainda não estiver adicionado
if ! asdf plugin-list | grep -q python; then
    asdf plugin-add python
fi

# Buscar a versão mais recente estável do Python e instalá-la
latest_stable_python_version=$(asdf list-all python | grep -v "[a-zA-Z]" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -1)
asdf install python "$latest_stable_python_version"
asdf global python "$latest_stable_python_version"

echo "Instalação completa! Python $latest_stable_python_version configurado como global."
