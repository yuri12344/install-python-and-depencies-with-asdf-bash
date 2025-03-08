#!/bin/bash

# Faz o script encerrar se qualquer comando falhar
set -e

# Verifica se o asdf já está instalado
if [ -d ~/.asdf ]; then
  echo "asdf já está instalado."
else
  # Clona o repositório do asdf na versão v0.14.0
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
  
  # Adiciona as linhas ao ~/.bashrc apenas se não existirem
  if ! grep -q '^\. "\$HOME/.asdf/asdf.sh"$' ~/.bashrc; then
    echo '. "$HOME/.asdf/asdf.sh"' >> ~/.bashrc
    echo '. "$HOME/.asdf/completions/asdf.bash"' >> ~/.bashrc
  fi
fi

# Aplica as mudanças do ~/.bashrc no ambiente atual do script
source ~/.bashrc

# Atualiza os pacotes e instala as dependências necessárias
sudo apt update && sudo apt install -y \
  make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl \
  llvm libncursesw5-dev xz-utils tk-dev libxml2-dev \
  libxmlsec1-dev libffi-dev liblzma-dev

# Adiciona o plugin do Python ao asdf
asdf plugin-add python

# Instala o Python 3.13.0
asdf install python 3.13.0

# Define o Python 3.13.0 como versão global
asdf global python 3.13.0

# Mensagem final para o usuário
echo "Configuração concluída. Por favor, execute 'source ~/.bashrc' para usar o asdf no seu shell atual."
