#!/usr/bin/env bash
#
# install.sh - bootstrap dos dotfiles em uma máquina/SO novo.
#
# Idempotente: pode rodar quantas vezes quiser. Usa symlinks apontando
# pra este repo, então depois de instalar basta `git pull` pra atualizar
# a config (sem recopiar nada).
#
#   git clone git@github.com:berntau/dotfiles-bern.git
#   cd dotfiles-bern && ./install.sh
#
set -euo pipefail

# Diretório do repo (onde este script está), em caminho absoluto.
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_DIR="$HOME/.config/zsh"
PKGS=(zsh zoxide starship atuin)

# --- helpers de output ---
c_blue='\033[1;34m'; c_yellow='\033[1;33m'; c_green='\033[1;32m'; c_reset='\033[0m'
step() { printf "${c_blue}==>${c_reset} %s\n" "$1"; }
warn() { printf "${c_yellow}!! ${c_reset} %s\n" "$1"; }
ok()   { printf "${c_green}ok ${c_reset} %s\n" "$1"; }

# Cria symlink idempotente (força e trata alvo que já é link/dir).
link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  ok "link $dst -> $src"
}

# --- 1. pacotes ---
install_packages() {
  step "Instalando pacotes: ${PKGS[*]}"
  if command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm "${PKGS[@]}"
  else
    warn "Sem pacman (não-Arch). Instale manualmente o que faltar abaixo."
  fi
  # Verifica o que ficou faltando (útil em SO sem pacman).
  local missing=()
  for t in "${PKGS[@]}"; do command -v "$t" >/dev/null 2>&1 || missing+=("$t"); done
  if [ "${#missing[@]}" -gt 0 ]; then
    warn "Ainda faltam: ${missing[*]} — instale pelo gerenciador do seu SO."
    warn "  starship: https://starship.rs/  |  atuin: https://atuin.sh/"
  fi
}

# --- 2. shell padrão = zsh ---
set_default_shell() {
  step "Definindo zsh como shell padrão"
  local zsh_path; zsh_path="$(command -v zsh || true)"
  if [ -z "$zsh_path" ]; then warn "zsh não instalado; pulando chsh."; return; fi
  local current; current="$(getent passwd "$USER" | cut -d: -f7)"
  if [ "$current" = "$zsh_path" ]; then
    ok "shell já é zsh ($zsh_path)"
  else
    warn "Trocando shell pra $zsh_path (pode pedir sua senha)"
    chsh -s "$zsh_path" || warn "chsh falhou; rode manualmente: chsh -s $zsh_path"
  fi
}

# --- 3. symlinks da config ---
link_configs() {
  step "Linkando arquivos de config"
  link "$REPO/.zshrc"  "$ZSH_DIR/.zshrc"
  link "$REPO/aliases" "$ZSH_DIR/aliases"
  link "$REPO/envs"    "$ZSH_DIR/envs"
  link "$REPO/prompt"  "$ZSH_DIR/prompt"
  link "$ZSH_DIR/.zshrc"      "$HOME/.zshrc"
  link "$REPO/starship.toml"  "$HOME/.config/starship.toml"
}

# --- 4. secrets (arquivo REAL, nunca symlink pro repo) ---
setup_secrets() {
  step "Preparando arquivo de secrets"
  local sec="$ZSH_DIR/secrets"
  if [ -e "$sec" ]; then
    ok "secrets já existe (mantido)"
  else
    install -m 600 "$REPO/secrets.example" "$sec"
    warn "Criado $sec a partir do exemplo — edite com suas chaves reais (chmod 600)."
  fi
}

# --- 5. avisos finais ---
final_notes() {
  step "Pronto!"
  warn "Fonte: o prompt usa glifos powerline/Nerd Font. Se os ícones saírem"
  warn "  quebrados, instale uma Nerd Font (ex.: 'CaskaydiaCove Nerd Font')."
  warn "Atuin (opcional, histórico sincronizado): atuin register / import / sync"
  echo
  ok "Abra um terminal novo (ou rode: zsh) pra usar a config."
}

install_packages
set_default_shell
link_configs
setup_secrets
final_notes
