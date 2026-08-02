;; ==========================================================================
;; Doas
;; ==========================================================================

(define-module (system doas)
  #:use-module (guix gexp)
  #:use-module (gnu system privilege)
  #:use-module (gnu packages admin)
  #:export (system-doas))

(define system-doas
    (privileged-program
      (program (file-append opendoas "/bin/doas"))
      (setuid? #t)))
