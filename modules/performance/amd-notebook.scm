;; modules/performance/amd-notebook.scm
;; Equivalente: modules/performance/amd-notebook.nix
;;
;; Gerenciamento de energia para notebooks AMD.

(define-module (modules performance amd-notebook)
  #:use-module (gnu services)
  #:use-module (gnu services desktop)
  #:use-module (gnu services linux)
  #:export (performance-services))

(define performance-services
  (list
    ;; power-profiles-daemon (equivale a services.power-profiles-daemon.enable)
    ;; Permite alternar entre perfis: power-saver, balanced, performance
    (service power-profiles-daemon-service-type)

    ;; systemd-oomd equivalente: earlyoom
    ;; O Guix não tem oomd direto; earlyoom cumpre a mesma função.
    (service earlyoom-service-type
      (earlyoom-configuration
        ;; Mata processos quando memória < 5% ou swap < 5%
        (minimum-available-memory 5)
        (minimum-free-swap 5)))))
