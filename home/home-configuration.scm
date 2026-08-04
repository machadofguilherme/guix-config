;; ============================================================================
;; GNU Guix System Home Configuration
;;
;; Hostname : guix
;; Machine  : VAIO FE15 (Ryzen 7 5700U)
;; Author   : Guilherme Machado
;;
;; Este arquivo descreve o ambiente pessoal.
;; O objetivo é manter uma configuração simples, organizada e fácil de entender.
;; ============================================================================

(use-modules (gnu home)
             (gnu home services)
             (gnu home services fontutils)
             (gnu services)
             (guix gexp)
             (home packages)
             (home variables)
             (home fish))

(home-environment
 (packages home-packages)
 (services
  (append
   (list
    (simple-service 'global-env-vars
                     home-environment-variables-service-type
                     home-global-variables))
   fish-services)))
