;; ============================================================================
;; GNU Guix System Configuration
;;
;; Hostname : guix
;; Machine  : VAIO FE15 (Ryzen 7 5700U)
;; Author   : Guilherme Machado
;;
;; Este arquivo descreve completamente o sistema operacional.
;; O objetivo é manter uma configuração simples, organizada e fácil de entender.
;; ============================================================================

(use-modules
  (gnu system)
  (gnu system keyboard)

  (gnu services xorg)
  (gnu services base)
  (gnu services desktop)
  (gnu services networking)

  (srfi srfi-1)

  (system boot)
  (system doas)
  (system user)
  (system packages)
  (system services)
  (system filesystem))

(define loadkeys-layout (keyboard-layout "br" "abnt2"))

(operating-system
  (host-name "guix")
  (timezone "America/Sao_Paulo")
  (locale "pt_BR.UTF-8")
  (keyboard-layout loadkeys-layout)
  (users (cons system-user %base-user-accounts))
  (privileged-programs (cons system-doas %default-privileged-programs))
  (file-systems system-file-systems)
  (bootloader system-bootloader)
  (kernel system-kernel)
  (initrd system-initrd)
  (firmware system-firmware)
  (kernel-arguments system-kernel-arguments)
  (packages (append system-packages %base-packages))

  ;; Serviços modificados.
  (services
    (append
      system-services
        (remove
          (lambda (service)
            (eq? (service-type-name (service-kind service)) 'network-manager-applet))
        (modify-services %desktop-services
          (delete gdm-service-type)
          (delete mingetty-service-type)
          (console-font-service-type config =>
            (remove (lambda (pair) (string=? (car pair) "tty1")) config))
          (ntp-service-type config =>
            (ntp-configuration
              (inherit config)
                (servers
                  (cons
                    (ntp-server
                      (type 'server)
                      (address "br.pool.ntp.org")
                      (options '(iburst (version 4) (maxpoll 16) prefer)))
                  %ntp-servers)))))))))
