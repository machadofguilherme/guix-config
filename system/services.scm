;; ==========================================================================
;; Serviços
;; ==========================================================================

(define-module (system services)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (gnu system)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services linux)
  #:use-module (gnu services docker)
  #:use-module (gnu services desktop)
  #:use-module (gnu services sddm)
  #:use-module (gnu services dbus)
  #:use-module (gnu system pam)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages display-managers)
  #:export (system-services))


(define guix-config-ownership-service
  (simple-service 'guix-config-ownership
                   activation-service-type
                   #~(begin
                       (chown "/etc/guix" (passwd:uid (getpwnam "guilherme"))
                                          (passwd:gid (getpwnam "guilherme")))
                       (chmod "/etc/guix" #o755))))


(define system-services
  (list
    ;; Permissão do /etc/guix
    guix-config-ownership-service

    ;; Consoles de texto
    (service mingetty-service-type (mingetty-configuration (tty "tty2")))
    (service mingetty-service-type (mingetty-configuration (tty "tty3")))
    (service mingetty-service-type (mingetty-configuration (tty "tty4")))
    (service mingetty-service-type (mingetty-configuration (tty "tty5")))
    (service mingetty-service-type (mingetty-configuration (tty "tty6")))

    ;; TRIM automático para SSD
    (service fstrim-service-type)

    ;; Mata processos quando memória acabar
    (service earlyoom-service-type)

    ;; Plasma
    (service plasma-desktop-service-type)

    ;; Docker
    (service docker-service-type)
    (service containerd-service-type)

    ;; SDDM Wayland
    (service sddm-service-type
      (sddm-configuration
        (sddm sddm)
        (theme "breeze")
        (display-server "wayland")))

    ;; doas
    (simple-service 'doas-config
      etc-service-type
      (list
        `("doas.conf"
          ,(plain-file
             "doas.conf"
             "permit nopass :wheel\n"))))

	;; Gamemode
    (simple-service 'gamemode-polkit-actions
      polkit-service-type
      (list gamemode))

    ;; ZRAM 16 GiB
    (service zram-device-service-type
      (zram-device-configuration
        (size (* 16 (expt 2 30)))
        (compression-algorithm 'zstd)))

    ;; Limite de arquivos
    (service pam-limits-service-type
      (list
        (pam-limits-entry "*" 'both 'nofile 1048576)))))
