;; modules/system/user.scm
;; Equivalente: modules/system/user.nix

(define-module (modules system user)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages shells)
  #:export (system-users
            system-groups))

(define system-users
  (list
    ;; Equivale a users.users.guilherme
    (user-account
      (name "guilherme")
      (comment "Guilherme Machado")
      (group "users")
      ;; Equivale a extraGroups = ["wheel" "audio" "video" "docker" "networkmanager"]
      (supplementary-groups '("wheel"
                               "audio"
                               "video"
                               "docker"
                               "netdev"         ;; equivalente ao networkmanager group
                               "input"
                               "kvm"))
      ;; Equivale a users.defaultUserShell = pkgs.fish
      (shell (file-append fish "/bin/fish"))
      (home-directory "/home/guilherme")
      (create-home-directory? #t))))

(define system-groups
  (list
    (user-group (name "netdev") (system? #t))
    (user-group (name "docker") (system? #t))
    (user-group (name "kvm") (system? #t))))
