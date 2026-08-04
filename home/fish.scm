;; ==========================================================================
;; Fish Shell
;; ==========================================================================

(define-module (home fish)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (guix gexp)
  #:use-module (home aliases)
  #:export (fish-services))

(define fish-services
  (list
   (service home-fish-service-type
            (home-fish-configuration
             (environment-variables
              `(("MANPAGER" . "less")))
             (aliases fish-aliases)
             (abbreviations fish-abbreviations)))

   (simple-service 'fish-extra-conf
                    home-xdg-configuration-files-service-type
                    (list `("fish/conf.d/90-extra.fish"
                            ,(plain-file "90-extra.fish"
                                         "\
starship init fish | source

set fish_greeting

fish_add_path $HOME/.local/bin $HOME/.npm-global/bin

set -x SSH_ENV \"$HOME/.keychain/$hostname-fish\"
eval (keychain --eval --quiet ~/.ssh/id_rsa)

pfetch
"))))))
