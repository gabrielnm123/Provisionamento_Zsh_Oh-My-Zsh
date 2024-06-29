#!/bin/bash

# Instala dependências
sudo apt update
sudo apt install -y zsh curl git

# Instala Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Definir variável ZSH_CUSTOM se não estiver definida
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# Certifique-se de que o diretório $ZSH_CUSTOM existe
mkdir -p "$ZSH_CUSTOM/themes"

# Clona spaceship-prompt, tema para zsh, para $ZSH_CUSTOM/themes/spaceship-prompt
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1

# Cria link simbólico do arquivo spaceship.zsh-theme, que está na pasta clonada, para a pasta themes do $ZSH_CUSTOM
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Troca o tema atual para spaceship
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="spaceship"/' ~/.zshrc

# Configurando o spaceship
echo 'SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "' >> ~/.zshrc

# Baixando e instalando o ZInit
zsh -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Com o ZInit serão instalados três plugins
echo 'zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions' >> ~/.zshrc

# Recarrega as configurações do Zsh
source ~/.zshrc

## Mudando o shell do usuário logado para Zsh

# Obtém o nome de usuário atual
username=$(whoami)

# Obtém o caminho do shell Zsh
zsh_path=$(which zsh)

# Altera o shell do usuário no arquivo /etc/passwd
sudo usermod --shell $zsh_path $username

# Notifica o usuário
echo "O shell padrão do usuário $username foi alterado para Zsh."
echo "Por favor, faça logout e login novamente para usar o novo shell."
