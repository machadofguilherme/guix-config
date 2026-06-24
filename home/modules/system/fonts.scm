;; home/modules/system/fonts.scm
;; Equivalente: home/modules/system/fonts.nix
;;
;; Fontes instaladas no perfil do usuário.
;; Em Guix, fontes no perfil do usuário são detectadas automaticamente
;; pelo fontconfig quando estão em ~/.guix-profile/share/fonts/.

(define-module (home modules system fonts)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:export (home-font-packages))

(define home-font-packages
  (list
    ;; Terminal / Código
    font-fira-code
    font-jetbrains-mono   ;; JetBrains Mono (sem nerd font patch)
    font-mononoki         ;; alternativa monospace
    font-iosevka          ;; fonte monospace alternativa

    ;; Compatibilidade / Iconografia
    font-awesome          ;; ícones
    font-google-noto
    font-google-noto-emoji

    ;; Ferramentas de fonte
    fontconfig
    freetype))

;; Nota: Para fontes Nerd Font (com patches de ícones), não há pacotes
;; oficiais no Guix. Você pode:
;; 1. Baixar manualmente de https://www.nerdfonts.com/ e instalar em ~/.fonts/
;; 2. Usar font-awesome para ícones no terminal
