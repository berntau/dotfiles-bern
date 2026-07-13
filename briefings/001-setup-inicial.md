# Briefing 001 - omarchy-zsh (setup pessoal de ZSH pro Omarchy)

## Contexto

O Fabio Akita (akitaonrails.com) publicou um post ensinando a trocar o
Bash padrão do Omarchy 2.0 por ZSH, com um repo de configs prontas
(`github.com/akitaonrails/omarchy-zsh`). Esse repo saiu do ar (404
confirmado via API do GitHub). Este repositório é uma recriação do
setup, feita a partir do conteúdo do post original, adaptada pro meu
próprio uso.

Fonte: https://akitaonrails.com/2025/09/07/omarchy-2-0-zsh-configs/

## Objetivo

Ter um `~/.config/zsh` versionado, sincronizável entre máquinas via
Git, com:
- Shell ZSH configurado no lugar do Bash padrão do Omarchy.
- Histórico de comandos sincronizado e encriptado (Atuin).
- Prompt customizado (Starship).
- Segredos (API keys) isolados do restante da config, fora do controle
  de versão de verdade.
- Aliases de produtividade (git, ferramentas do dia a dia).

## Estado atual do repo

Já existe localmente (`omarchy-zsh/`) com o primeiro commit feito,
contendo:

| Arquivo     | Função                                                        |
|-------------|----------------------------------------------------------------|
| `.zshrc`    | Entry point — sourcea zoxide, atuin, prompt, aliases, envs, secrets |
| `prompt`    | Gera `starship.toml` a partir de um preset e inicializa o Starship |
| `aliases`   | Aliases de git (`g a`, `g c`, `g ps`...) + aliases pessoais     |
| `envs`      | Variáveis de ambiente (Ollama, OpenRouter etc)                 |
| `secrets`   | Template pra API keys — **NÃO deve ir com valores reais pro Git** |
| `README.md` | Instruções de instalação                                       |

## Tarefas pendentes

1. **Criar o repo remoto no GitHub**
   - Nome sugerido: `omarchy-zsh` (mesmo nome do original, deixa claro
     que é uma recriação/derivação).
   - Visibilidade: a definir (privado recomendado por causa do arquivo
     `secrets`, mesmo que hoje só tenha placeholder).
   - Comando: `gh repo create omarchy-zsh --private --source=. --remote=origin --push`

2. **Adicionar `.gitignore` pro `secrets`**
   - Hoje o `secrets` está versionado com placeholder. Decidir: manter
     versionado só como template (`secrets.example`) e ignorar o
     arquivo real (`secrets`), ou manter fora do Git desde já.
   - Critério de aceite: `git status` não deve nunca acusar mudança no
     arquivo `secrets` depois que ele tiver chaves reais.

3. **Revisar e personalizar `aliases`**
   - Remover `monhd`/`mondp` (específicos do setup de 2 GPUs do Akita)
     se eu não usar `ddcutil`.
   - Adicionar aliases do meu próprio workflow (ex: atalhos pros
     projetos IMOBVELLOR, AgendaBot, anki-concursos etc).

4. **Revisar `envs`**
   - Trocar `DEFAULT_MODEL`/`OPENAI_API_BASE` pros valores que eu
     realmente uso (hoje está com os valores de exemplo do Akita,
     voltados pra Ollama local dele).

5. **Instalar de fato no Omarchy**
   - `yay -S zsh zoxide starship atuin`
   - `chsh -s $(which zsh)`
   - Symlink `~/.zshrc` -> `~/.config/zsh/.zshrc`
   - Configurar Atuin (`atuin register`, `atuin sync`) e guardar a
     chave de encriptação num cofre de senhas.

6. **Testar em máquina limpa (opcional)**
   - Validar que só com `git clone` + os passos do README, o setup
     completo sobe sem depender de nada que ficou só na minha máquina
     atual.

## Critério de aceite geral

- Repo publicado no GitHub, sob controle de versão, sem segredos reais
  commitados.
- `~/.zshrc` funcionando via symlink, ZSH ativo como shell padrão.
- Atuin sincronizando histórico.
- Prompt Starship visível e correto.
- Aliases de git funcionando (`g s`, `g c "msg"` etc).

## Fora de escopo (por enquanto)

- Migrar outras configs (Hyprland, Waybar, Neovim) pra este mesmo
  repo — se um dia eu quiser um `dotfiles` mais amplo, isso vira outro
  briefing.
