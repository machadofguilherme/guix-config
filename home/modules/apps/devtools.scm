;; home/modules/apps/devtools.scm
;; Equivalente: home/modules/apps/devtools.nix
;;
;; PACOTES INDISPONÍVEIS NO GUIX (da sua config original):
;;   - gitmoji-cli  → substitua por commitizen ou convencional commits
;;   - ngrok        → não disponível; use bore ou localtunnel
;;   - postman      → use insomnia (pode estar disponível) ou Bruno
;;   - mongosh      → não disponível; use MongoDB Compass via Flatpak
;;   - bun          → verificar disponibilidade; pode não estar no Guix
;;
;; DISPONÍVEIS:
;;   - gh (GitHub CLI)  ✓
;;   - maven            ✓
;;   - vscode           ✗ (use vscodium — code aberto do VSCode)
;;   - rust / cargo     ✓ (via pacote 'rust')
;;   - openjdk21        ✓
;;   - direnv           ✓

(define-module (home modules apps devtools)
  #:use-module (gnu packages)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages build-tools)
  #:use-module (gnu packages java)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages node)
  #:use-module (gnu packages admin)
  #:export (devtools-packages))

(define devtools-packages
  (list
    ;; GitHub CLI
    gh

    ;; Java / Maven
    openjdk-21
    maven

    ;; Rust
    rust        ;; inclui cargo, rustc, rustfmt
    rust-analyzer

    ;; Node.js
    node    ;; ou 'node' para versão atual

    ;; Ferramentas de ambiente
    direnv

    ;; Editor / IDE alternativo ao VSCode
    vscodium    ;; VSCode open-source (sem telemetria Microsoft)

    ;; Git helpers
    git
    git-lfs))
