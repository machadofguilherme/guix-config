;; home/modules/shell/aliases.scm
;; Equivalente: home/modules/shell/aliases.nix
;;
;; Aliases adaptados para o Guix (comandos nix-* substituídos por guix-*).

(define-module (home modules shell aliases)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:export (aliases-services))

(define guix-aliases
  '(;; ╭────────────────────────────╮
    ;; │ 🔄  SISTEMA GUIX           │
    ;; ╰────────────────────────────╯
    ("guix-pull"          . "sudo guix pull")
    ("guix-rebuild"       . "sudo guix system reconfigure /etc/guix/config.scm")
    ("guix-home"          . "guix home reconfigure /etc/guix/home/home.scm")
    ("guix-gc"            . "sudo guix gc --delete-generations=2d && sudo guix gc")

    ;; ╭────────────────────────────╮
    ;; │ 🧹 Limpeza                 │
    ;; ╰────────────────────────────╯
    ("guix-clean-sys"     . "sudo guix system delete-generations 2d")
    ("guix-clean-home"    . "guix home delete-generations 2d")
    ("guix-clean-pkgs"    . "guix package --delete-generations=2d")

    ;; ╭────────────────────────────╮
    ;; │ 🛠️  CONFIGS PRINCIPAIS      │
    ;; ╰────────────────────────────╯
    ("cfg-system"         . "nano /etc/guix/config.scm")
    ("cfg-channels"       . "nano ~/.config/guix/channels.scm")
    ("hm-home"            . "nano /etc/guix/home/home.scm")

    ;; ╭────────────────────────────╮
    ;; │ 🧩  MÓDULOS: SYSTEM        │
    ;; ╰────────────────────────────╯
    ("cfg-boot"           . "nano /etc/guix/modules/boot/boot.scm")
    ("cfg-kernel"         . "nano /etc/guix/modules/boot/kernel.scm")
    ("cfg-drivers"        . "nano /etc/guix/modules/graphical/drivers.scm")
    ("cfg-environment"    . "nano /etc/guix/modules/graphical/environment.scm")
    ("cfg-net"            . "nano /etc/guix/modules/network/net.scm")
    ("cfg-dns"            . "nano /etc/guix/modules/network/dns.scm")
    ("cfg-audio"          . "nano /etc/guix/modules/services/audio.scm")
    ("cfg-docker"         . "nano /etc/guix/modules/services/docker.scm")
    ("cfg-gaming"         . "nano /etc/guix/modules/system/gaming.scm")
    ("cfg-packages"       . "nano /etc/guix/modules/system/packages.scm")
    ("cfg-user"           . "nano /etc/guix/modules/system/user.scm")
    ("cfg-fonts"          . "nano /etc/guix/modules/system/fonts.scm")

    ;; ╭────────────────────────────╮
    ;; │ 🐚  HOME MANAGER: SHELL    │
    ;; ╰────────────────────────────╯
    ("hm-fish"            . "nano /etc/guix/home/modules/shell/fish.scm")
    ("hm-aliases"         . "nano /etc/guix/home/modules/shell/aliases.scm")
    ("hm-starship"        . "nano /etc/guix/home/modules/shell/starship.scm")
    ("hm-git"             . "nano /etc/guix/home/modules/git/default.scm")
    ("hm-devtools"        . "nano /etc/guix/home/modules/apps/devtools.scm")
    ("hm-media"           . "nano /etc/guix/home/modules/apps/media.scm")
    ("hm-utilities"       . "nano /etc/guix/home/modules/apps/utilities.scm")
    ("hm-variables"       . "nano /etc/guix/home/modules/system/variables.scm")
    ("hm-fonts"           . "nano /etc/guix/home/modules/system/fonts.scm")

    ;; ╭────────────────────────────╮
    ;; │ 🐳  Docker                 │
    ;; ╰────────────────────────────╯
    ("docker-up"          . "docker compose up -d")
    ("docker-down"        . "docker compose down")

    ;; ╭────────────────────────────╮
    ;; │ 📁  GIT /etc/guix          │
    ;; ╰────────────────────────────╯
    ("gs"                 . "cd /etc/guix && git status")
    ("gp"                 . "cd /etc/guix && git add -A && git commit && git push")))

(define aliases-services
  (list
    (service home-fish-service-type
      (home-fish-configuration
        (aliases guix-aliases)))))
