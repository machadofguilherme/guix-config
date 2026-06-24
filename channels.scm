;; ~/.config/guix/channels.scm
;;
;; Execute antes de tudo:
;;   mkdir -p ~/.config/guix
;;   cp channels.scm ~/.config/guix/channels.scm
;;   guix pull
;;
;; nonguix fornece: linux (kernel não-livre), steam, discord, firefox, etc.

(list
  (channel
    (name 'guix)
    (url "https://git.savannah.gnu.org/git/guix.git")
    (branch "master"))

  (channel
    (name 'nonguix)
    (url "https://gitlab.com/nonguix/nonguix")
    (branch "master")))
