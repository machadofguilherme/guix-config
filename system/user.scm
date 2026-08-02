;; ==========================================================================
;; Usuários
;; ==========================================================================

(define-module (system user)
  #:use-module (guix gexp)
  #:use-module (gnu system accounts)
  #:use-module (gnu packages shells)
  #:export (system-user))

(define system-user
  (user-account
      (name "guilherme")
      (comment "Guilherme Machado")
      (group "users")
      (home-directory "/home/guilherme")
      (shell (file-append fish "/bin/fish"))

      ;; Grupos suplementares.
      (supplementary-groups
        '("wheel"
          "netdev"
          "audio"
          "video"
          "kvm"))))

