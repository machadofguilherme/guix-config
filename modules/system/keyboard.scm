;; modules/system/keyboard.scm
;; Equivalente: modules/system/keyboard.nix

(define-module (modules system keyboard)
  #:use-module (gnu system keyboard)
  #:export (system-keyboard))

;; Equivale a:
;;   services.xserver.xkb.layout = "br"
;;   console.keyMap = "br-abnt2"
(define system-keyboard
  (keyboard-layout "br" "abnt2"))
