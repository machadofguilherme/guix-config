;; home/modules/git/default.scm
;; Equivalente: home/modules/git/default.nix

(define-module (home modules git default)
  #:use-module (gnu home services)
  #:use-module (gnu home services version-control)
  #:export (git-services))

;; Equivale ao programs.git do Home Manager
(define git-services
  (list
    (service home-git-service-type
      (home-git-configuration
        (config
          `((user
              (name  . "Guilherme Machado")
              (email . "machadofguilherme@proton.me"))
            (init
              (defaultBranch . "main"))
            (safe
              (directory . "/etc/guix"))
            (safe
              (directory . "/home/guilherme/Projetos"))))))))
