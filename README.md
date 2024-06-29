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
curl -s https://raw.githubusercontent.com/gabrielnm123/Provisionamento_Zsh_Oh-My-Zsh/main/provision.sh | sudo -E bash
```

> Se conseguir usar a fonte [Fira Code](https://github.com/tonsky/FiraCode/releases), vai poder usar diversos ícones dos quais são utilizados nesse tema.
