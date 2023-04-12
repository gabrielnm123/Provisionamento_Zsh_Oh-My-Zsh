#!/bin/zsh

# Clona spaceship-prompt, tema para zsh, para $HOME/.oh-my-zsh/themes/spaceship-prompt
git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/themes/spaceship-prompt"

# Cria link simbólico do arquivo spaceship.zsh-theme, que esta na pasta clonada, para a pasta pai do repositorio
ln -s "$HOME/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/themes/spaceship.zsh-theme"

# Troca o tema de devcontainers para spaceship
sed -i '11s/ZSH_THEME="devcontainers"/ZSH_THEME="spaceship"/g' ~/.zshrc

# Configurando o spaceship, desabilitando algumas funções que requerem mais processamento e que podem fazer o carregamento das pastas demorarem
echo 'SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "' | cat >> ~/.zshrc

# Bixando e instalando o ZInit
yes | zsh -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Com o ZInit será instalado três plugins
# zdharma/fast-syntax-highlighting: Adiciona syntax highlighting na hora da escrita de comandos que # facilita principalmente em reconhecer comandos que foram digitados de forma incorreta;
# zsh-users/zsh-autosuggestions: Sugere comandos baseados no histórico de execução conforme você vai # digitando;
# zsh-users/zsh-completions: Adiciona milhares de completitions para ferramentas comuns como Yarn, # Homebrew, NVM, Node, etc, para você precisar apenas apertar TAB para completar comandos;
echo 'zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions' | cat >> ~/.zshrc
source ~/.zshrc

# Instala Pyenv
curl https://pyenv.run | zsh
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
exec "$SHELL"
