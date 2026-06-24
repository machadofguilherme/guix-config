;; modules/security/sudo.scm
;; Equivalente: modules/security/sudo.nix

(define-module (modules security sudo)
  #:use-module (gnu services)
  #:use-module (gnu services admin)
  #:export (sudo-services))

(define sudo-services
  (list
    ;; Equivale a:
    ;;   security.sudo.execWheelOnly = true
    ;;   security.sudo.wheelNeedsPassword = false
    (service sudo-service-type
      (sudo-configuration
        ;; Apenas binários em PATH seguros podem ser executados via sudo
        (wheel-can-sudo? #t)
        ;; Membros do grupo 'wheel' não precisam de senha
        (sudoers-file (plain-file "sudoers"
          "Defaults secure_path="/run/current-system/profile/bin:/run/current-system/profile/sbin"
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
"))))))
