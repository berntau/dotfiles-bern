#!/usr/bin/env zsh
# Reconstrução do omarchy-zsh do Akita, baseada no post:
# https://akitaonrails.com/2025/09/07/omarchy-2-0-zsh-configs/
#
# O repo original (github.com/akitaonrails/omarchy-zsh) não está mais
# acessível (404), então este arquivo foi remontado a partir do conteúdo
# descrito no post. Ajuste conforme necessário.

# --- zoxide (cd inteligente) ---
eval "$(zoxide init zsh)"

# --- Atuin (histórico de comandos sincronizado/encriptado) ---
eval "$(atuin init zsh)"

# --- Segredos (API keys etc, NUNCA commitar isso) ---
[ -f ~/.config/zsh/secrets ] && source ~/.config/zsh/secrets

# --- Variáveis de ambiente (Ollama, OpenRouter etc) ---
[ -f ~/.config/zsh/envs ] && source ~/.config/zsh/envs

# --- Aliases pessoais ---
[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases

# --- Prompt (Starship) ---
[ -f ~/.config/zsh/prompt ] && source ~/.config/zsh/prompt


