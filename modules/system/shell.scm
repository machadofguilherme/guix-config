;; modules/system/shell.scm
;; Equivalente: modules/system/shell.nix
;;
;; Fish como shell padrão do sistema.

(define-module (modules system shell)
  #:use-module (gnu packages shells)
  #:export (default-shell
            shell-packages))

;; Equivale a users.defaultUserShell = pkgs.fish
(define default-shell fish)

;; Pacotes de shell necessários no sistema
(define shell-packages
  (list fish))
