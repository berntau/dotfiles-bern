# dotfiles-bern

Meus dotfiles portáteis — pra reconfigurar rápido o terminal que eu gosto
(zsh + starship + zoxide + atuin) toda vez que eu troco de máquina ou SO.

Base: config `~/.config/zsh` do Akita, reconstruída a partir do post
[Omarchy 2.0 - ZSH Configs](https://akitaonrails.com/2025/09/07/omarchy-2-0-zsh-configs/)
(o repo original `github.com/akitaonrails/omarchy-zsh` saiu do ar — 404).

## Instalação rápida (máquina nova)

```bash
git clone git@github.com:berntau/dotfiles-bern.git
cd dotfiles-bern
./install.sh
```

O `install.sh` é **idempotente** (pode rodar de novo sem medo) e faz:

- instala `zsh zoxide starship atuin` (via `pacman` no Arch; em outros SO
  ele avisa o que falta instalar na mão);
- define o `zsh` como shell padrão (`chsh`);
- cria **symlinks** de `~/.config/zsh/*` e `~/.config/starship.toml`
  apontando pra este repo — então depois é só `git pull` pra atualizar;
- cria `~/.config/zsh/secrets` (com `chmod 600`) a partir do
  `secrets.example`, se ainda não existir.

Depois, abra um terminal novo (ou rode `zsh`).

## O que tem aqui

| Arquivo | O quê |
|---|---|
| `.zshrc` | entrypoint: faz `source` dos demais |
| `aliases` | aliases de shell + aliases de git (`git config`) |
| `envs` | variáveis de ambiente (Ollama, OpenRouter etc) |
| `prompt` | inicializa o starship (`eval`) |
| `starship.toml` | tema do prompt: preset *pastel-powerline* + relógio `♡` |
| `secrets.example` | template pro `secrets` (o real é gitignorado) |
| `install.sh` | bootstrap idempotente |

## Depois de instalar

1. Edite `~/.config/zsh/secrets` com suas chaves reais (API keys, tokens).
   O arquivo é gitignorado — nunca vai pro repo.
2. Ajuste `aliases`/`envs` como preferir. Os aliases de monitor
   `monhd`/`mondp` são específicos de setup com `ddcutil` — remova se não usar.
3. **Fonte:** o prompt usa glifos powerline/Nerd Font. Se os ícones saírem
   quebrados, instale uma Nerd Font (ex.: *CaskaydiaCove Nerd Font*).
4. **Atuin** (opcional — histórico sincronizado e encriptado entre máquinas):
   ```bash
   atuin register -u <seu-usuario> -e <seu-email>
   atuin import auto
   atuin sync
   ```
   Guarde a chave de encriptação num cofre de senhas — sem ela não dá pra
   recuperar o histórico numa reinstalação.

## Atualizar a config

Como tudo é symlink pro repo, basta:

```bash
cd ~/Documents/github/dotfiles-bern   # ou onde você clonou
git pull
```

Editou algo? Commite e mande pro GitHub — nas outras máquinas é só dar `git pull`.

## O que ficou de fora

O `.zshrc` original do Akita tinha uma linha `source ~/.config/zsh/mounts`
que ele mesmo recomenda remover — era só pra checar os mounts NFS do NAS
pessoal dele.
