;; modules/security/ulimit.scm
;; Equivalente: modules/security/ulimit.nix
;;
;; Aumenta o limite de arquivos abertos.
;; Equivale a security.pam.loginLimits com nofile = 1048576.

(define-module (modules security ulimit)
  #:use-module (gnu services)
  #:export (ulimit-etc-files))

;; Arquivo /etc/security/limits.conf
(define ulimit-etc-files
  `(("security/limits.conf"
     ,(plain-file "limits.conf"
        "# Aumenta limite de file descriptors para todos os usuários
*    -    nofile    1048576
root -    nofile    1048576
"))))
