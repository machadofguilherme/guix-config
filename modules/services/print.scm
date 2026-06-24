;; modules/services/print.scm
;; Equivalente: modules/services/print.nix
;;
;; Impressão desabilitada (services.printing.enable = false).
;; Para habilitar no futuro, descomente o bloco abaixo.

(define-module (modules services print)
  #:use-module (gnu services)
  #:export (print-services))

;; Impressão desabilitada — lista vazia de serviços.
(define print-services
  '())

;; Para habilitar impressão, troque por:
;; (define print-services
;;   (list
;;     (service cups-service-type
;;       (cups-configuration
;;         (web-interface? #t)))))
