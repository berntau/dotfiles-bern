# omarchy-zsh (reconstrução)

Reconstrução do `~/.config/zsh` do Akita, baseada no post
[Omarchy 2.0 - ZSH Configs](https://akitaonrails.com/2025/09/07/omarchy-2-0-zsh-configs/),
já que o repositório original `github.com/akitaonrails/omarchy-zsh` está
retornando 404 (não existe mais publicamente).

## Como instalar

1. Garanta que tem zsh, zoxide, starship e atuin instalados:
   ```bash
   yay -S zsh zoxide starship atuin
   chsh -s $(which zsh)
   ```

2. Copie esta pasta pra `~/.config/zsh`:
   ```bash
   mkdir -p ~/.config/zsh
   cp .zshrc prompt aliases envs secrets ~/.config/zsh/
   ln -sf ~/.config/zsh/.zshrc ~/.zshrc
   ```

3. Proteja o arquivo de segredos e edite com suas chaves de verdade:
   ```bash
   chmod 600 ~/.config/zsh/secrets
   nano ~/.config/zsh/secrets
   ```

4. Ajuste `aliases` e `envs` como preferir (os aliases de monitor
   `monhd`/`mondp` são específicos do setup de 2 GPUs do Akita — pode
   remover se não usar `ddcutil`).

5. Configure o Atuin (opcional, mas recomendado se quiser histórico
   sincronizado e encriptado entre máquinas):
   ```bash
   atuin register -u <seu-usuario> -e <seu-email>
   atuin import auto
   atuin sync
   ```
   Guarde a chave de encriptação gerada em um cofre de senhas — sem
   ela não dá pra recuperar o histórico numa reinstalação.

6. Logout/login (ou abra um terminal novo) pra tudo entrar em vigor.

## O que ficou de fora

O `.zshrc` original tinha uma linha extra `source ~/.config/zsh/mounts`
que o próprio Akita recomenda remover — é só pra checar os mounts NFS
do NAS pessoal dele.
