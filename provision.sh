#!/bin/bash

# Garante que o script pare se qualquer comando falhar
set -e

echo "🚀 Iniciando a configuração completa do ambiente Zsh..."

# --- 1. Instalação de Dependências ---
echo "📦 Instalando dependências (zsh, curl, git)..."
sudo apt update
sudo apt install -y zsh curl git

# --- 2. Instalação do Oh My Zsh ---
if [ -d "$HOME/.oh-my-zsh" ]; then
  echo "✅ Oh My Zsh já está instalado. Pulando."
else
  echo "📥 Instalando Oh My Zsh..."
  CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- 3. Instalação do Tema Spaceship ---
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
SPACESHIP_THEME_PATH="$ZSH_CUSTOM/themes/spaceship-prompt"

if [ -d "$SPACESHIP_THEME_PATH" ]; then
  echo "✅ Tema Spaceship já foi clonado. Pulando."
else
  echo "🎨 Clonando o tema Spaceship..."
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$SPACESHIP_THEME_PATH" --depth=1
  ln -s "$SPACESHIP_THEME_PATH/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

# --- 4. Instalação do Gerenciador de Plugins 'zi' ---
ZI_DIR="$HOME/.zi"
if [ -d "$ZI_DIR" ]; then
  echo "✅ Gerenciador de plugins 'zi' já está instalado. Pulando."
else
  echo "🔌 Instalando o gerenciador de plugins 'zi'..."
  git clone --depth=1 https://github.com/z-shell/zi.git "$ZI_DIR"
fi

# --- 5. Configuração do ~/.zshrc ---
echo "⚙️  Configurando o arquivo ~/.zshrc..."

# Define o tema para 'spaceship'
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="spaceship"/' "$HOME/.zshrc"

# **NOVO E CORRIGIDO:** Insere a configuração do Spaceship no local correto.
# As configurações são adicionadas logo após a linha ZSH_THEME.
if ! grep -q "SPACESHIP_USER_SHOW" "$HOME/.zshrc"; then
    echo "✍️  Inserindo configurações do Spaceship no local correto..."
    sed -i '/^ZSH_THEME="spaceship"/a \
\
# --- Configurações do Tema Spaceship ---\
SPACESHIP_USER_SHOW=always\
SPACESHIP_PROMPT_ADD_NEWLINE=false\
SPACESHIP_CHAR_SYMBOL="❯"\
SPACESHIP_CHAR_SUFFIX=" "' "$HOME/.zshrc"
fi

# Adiciona o gerenciador de plugins 'zi' no final do arquivo.
if ! grep -q "source ~/.zi/zi.zsh" "$HOME/.zshrc"; then
  echo "✍️  Adicionando o gerenciador de plugins 'zi' ao final do ~/.zshrc..."
  cat >> "$HOME/.zshrc" <<'EOF'

# --- Gerenciador de Plugins 'zi' ---
# Carrega o 'zi' a partir da sua instalação local e segura
source ~/.zi/zi.zsh

# Carrega os plugins essenciais usando o zi
zi light z-shell/F-Sy-H
zi light zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-completions
EOF
fi

# --- 6. Alteração do Shell Padrão ---
if [ "$(basename "$SHELL")" != "zsh" ]; then
  echo "셸 Alterando o shell padrão para Zsh. Você precisará fornecer sua senha."
  chsh -s "$(which zsh)"
  if [ $? -eq 0 ]; then
    echo "✅ Shell padrão alterado para Zsh com sucesso."
  else
    echo "⚠️ Falha ao alterar o shell padrão." >&2
  fi
else
  echo "✅ Zsh já é o seu shell padrão."
fi

# --- 7. Conclusão ---
echo ""
echo "🎉 Configuração concluída com sucesso!"
echo "➡️  Para aplicar todas as alterações, por favor, faça LOGOUT e LOGIN novamente ou reinicie o computador."
