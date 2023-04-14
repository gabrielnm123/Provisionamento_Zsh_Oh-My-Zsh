# Provisionamento_Zsh_Oh-My-Zsh

## Ao executar o arquivo provision.sh

1. Será instalado Zsh e Oh My Zsh
1. Será configurado o tema spaceship para Zsh
1. ZInit será instalado para configurar 3 plugins:

   * zdharma/fast-syntax-highlighting

      ***Adiciona syntax highlighting na hora da escrita de comandos que facilita principalmente em reconhecer comandos que foram digitados de forma incorreta***

   * zsh-users/zsh-autosuggestions

      ***Sugere comandos baseados no histórico de execução conforme você vai digitando***

   * zsh-users/zsh-completions

      ***Adiciona milhares de completitions para ferramentas comuns como Yarn, Homebrew, NVM, Node, etc, para você precisar apenas apertar TAB para completar comandos***

1. Muda o shell do usuário logado para Zsh

## Instalação automática

``` bash
sudo apt update && sudo apt install -y curl
curl -fsSLO https://raw.githubusercontent.com/gabrielnm123/Provisionamento_CodeSpaces-ZSH_PYENV/main/provision.sh && bash provision.sh
```
