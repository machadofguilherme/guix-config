;; home/modules/shell/fish.scm
;; Equivalente: home/modules/shell/fish.nix

(define-module (home modules shell fish)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages admin)
  #:export (fish-services))

(define fish-init-script
  ;; Equivale ao interactiveShellInit do Home Manager
  "# Remove mensagem de greeting do Fish
set -g fish_greeting \"\"

# Mostra informações do sistema
# pfetch — instale via home-packages se quiser
# pfetch

# ╭────────────────────────────────────────────────╮
# │ 🔮 Upgrade do sistema (guix equivalente)       │
# ╰────────────────────────────────────────────────╯
function guix-system-upgrade
    echo \"🔮 Atualizando canais Guix...\"
    sudo guix pull
    echo \"🚀 Reconfigurando sistema...\"
    sudo guix system reconfigure /etc/guix/config.scm
    echo \"✅ Sistema atualizado!\"
end

# ╭────────────────────────────────────────────────╮
# │ 🏠 Upgrade do home                             │
# ╰────────────────────────────────────────────────╯
function guix-home-upgrade
    echo \"🏠 Reconfigurando home Guix...\"
    guix home reconfigure /etc/guix/home/home.scm
    echo \"✅ Home atualizado!\"
end

# ╭────────────────────────────────────────────────╮
# │ 🧹 Limpeza da GNU Store                        |
# ╰────────────────────────────────────────────────╯
function guix-full-clean
    echo \"🧹 Iniciando limpeza da Guix Store...\"

    # Remove gerações antigas do sistema
    sudo guix system delete-generations 2d
    # Remove gerações antigas do home
    guix home delete-generations 2d
    # Remove gerações antigas dos perfis de usuário
    guix package --delete-generations=2d

    echo \"🗑️  Coletando lixo da store...\"
    sudo guix gc

    echo \"✨ Store limpa!\"
    echo \"📊 Espaço atual em /gnu/store:\"
    du -sh /gnu/store
end

# ╭────────────────────────────────────────────────╮
# │ 🔑 SSH Keychain                                │
# ╰────────────────────────────────────────────────╯
set -x SSH_ENV \"$HOME/.keychain/$hostname-fish\"

if test -f $SSH_ENV
    source $SSH_ENV
else
    eval (keychain --eval --quiet id_ed25519.pub)
end
")

(define fish-services
  (list
    (service home-fish-service-type
      (home-fish-configuration
        (config (list (plain-file "fish-init.fish" fish-init-script)))))))
