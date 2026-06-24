;; modules/services/docker.scm
;; Equivalente: modules/services/docker.nix

(define-module (modules services docker)
  #:use-module (gnu services)
  #:use-module (gnu services docker)
  #:export (docker-services))

(define docker-services
  (list
    ;; Docker (equivale a virtualisation.docker.enable = true)
    (service docker-service-type)))
