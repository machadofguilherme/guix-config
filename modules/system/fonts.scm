;; modules/system/fonts.scm
;; Equivalente: modules/system/fonts.nix

(define-module (modules system fonts)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages fontutils)
  #:export (system-font-packages))

;; Equivale ao fonts.packages do NixOS
;; Nota: nerd-fonts.jetbrains-mono e nerd-fonts.fira-code não existem como
;; pacotes separados em Guix — use font-jetbrains-mono e font-fira-code normais.
(define system-font-packages
  (list
    ;; UI / Texto
    font-google-noto               ;; Noto Sans, Serif, Emoji
    font-google-noto-emoji
    font-roboto
    font-open-sans                 ;; pode ser font-open-sans
    font-ubuntu

    ;; Código / Terminal
    font-fira-code
    font-jetbrains-mono

    ;; Compatibilidade Microsoft
    font-liberation                ;; substituto livre das fonts Microsoft
    ;; corefonts (nonfree) não está disponível no Guix padrão
    ))
