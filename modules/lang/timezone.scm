;; modules/lang/timezone.scm
;; Equivalente: modules/lang/timezone.nix

(define-module (modules lang timezone)
  #:export (system-timezone))

;; Equivale a time.timeZone = "America/Sao_Paulo"
(define system-timezone "America/Sao_Paulo")
