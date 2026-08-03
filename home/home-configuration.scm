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
