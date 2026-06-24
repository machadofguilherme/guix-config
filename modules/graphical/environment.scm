(define-module (modules graphical environment)
  #:use-module (gnu services)
  #:use-module (gnu services desktop)
  #:use-module (gnu services sddm)
  #:export (desktop-environment-services))

(define desktop-environment-services
  (list
    (service plasma-desktop-service-type)

    (service sddm-service-type
      (sddm-configuration
        (theme "breeze")
        (display-server "wayland")
        (auto-login-user "")
        (auto-login-session "plasmawayland")))))
