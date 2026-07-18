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
  (guix packages)
  (gnu)

  ;; Sistema
  (gnu system)
  (gnu system keyboard)
  (gnu system privilege)

  ;; Kernel + firmware não-livres (Nonguix)
  (nongnu packages linux)
  (nongnu system linux-initrd)

  ;; Boot
  (gnu bootloader)
  (gnu bootloader grub)

  ;; Serviços
  (gnu services)
  (gnu services linux)
  (gnu services docker)

  ;; Rede
  (gnu services networking)

  ;; Áudio
  (gnu services audio)

  ;; Desktop
  (gnu services desktop)
  (gnu services xorg)

  ;; Pacotes
  (gnu packages)
  (gnu packages admin)
  (gnu packages version-control)
  (gnu packages shells)
  (gnu packages ssh)
  (gnu packages shellutils)
  (gnu packages fonts)
  (gnu packages text-editors)
  (gnu packages wget)
  (gnu packages curl)
  (gnu packages crypto)
  (gnu packages gnome)
  (gnu packages package-management)
  (gnu packages ncurses)
  (gnu packages docker)
  (srfi srfi-1))

(define loadkeys-layout
  (keyboard-layout "br" "abnt2"))

(define %system-packages
  (list
    git
    fish
    nano
    curl
    wget
    btop
    pfetch
    ncurses
    flatpak
    starship
    openssh
    keychain
    font-nerd-jetbrains-mono ;; Será movido para guix home
    opendoas))

(operating-system
  (host-name "guix")
  (timezone "America/Sao_Paulo")
  (locale "pt_BR.UTF-8")
  (keyboard-layout loadkeys-layout)

  ;; ==========================================================================
  ;; Usuários
  ;; ==========================================================================

  (users
   (cons
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
          "kvm")))

    %base-user-accounts))

  ;; ==========================================================================
  ;; Doas
  ;; ==========================================================================

  (privileged-programs
    (cons (privileged-program
      (program (file-append opendoas "/bin/doas"))
      (setuid? #t))
      %default-privileged-programs))

  ;; ==========================================================================
  ;; Sistemas de arquivos
  ;; ==========================================================================

  (file-systems
   (cons*
    (file-system
      (mount-point "/")
      (device
        (uuid "ba518bb4-49dd-4841-a649-d4b3f768d9c3"))
      (type "btrfs")
      (options "subvol=@root,compress=zstd"))

    (file-system
      (mount-point "/home")
      (device
        (uuid "ba518bb4-49dd-4841-a649-d4b3f768d9c3"))
      (type "btrfs")
      (options "subvol=@home,compress=zstd"))

    (file-system
      (mount-point "/gnu/store")
      (device
        (uuid "ba518bb4-49dd-4841-a649-d4b3f768d9c3"))
      (type "btrfs")
      (options "subvol=@store,compress=zstd"))

    (file-system
      (mount-point "/boot/efi")
      (device
        (uuid "76A1-906B" 'fat32))
      (type "vfat"))

    %base-file-systems))

  ;; ==========================================================================
  ;; Bootloader
  ;; ==========================================================================

  (bootloader
   (bootloader-configuration
     (bootloader grub-efi-bootloader)

     (targets
       '("/boot/efi"))))

  (kernel linux)
  (initrd microcode-initrd)
  (firmware
   (list linux-firmware amd-microcode))

  (packages
   (append
    %system-packages
    %base-packages))

;; ==========================================================================
  ;; Serviços
  ;; ==========================================================================

  (services
   (cons*
    (service fstrim-service-type)

    (service earlyoom-service-type)

    (service gnome-desktop-service-type
       (gnome-desktop-configuration
         (utilities
           (fold delete
             (gnome-desktop-configuration-utilities (gnome-desktop-configuration))
               (map specification->package
                 '("epiphany" "cheese" "gnome-maps" "gnome-weather"
                   "gnome-contacts" "gnome-music" "decibels"
                   "gnome-clocks" "gnome-connections" "simple-scan"
                   "gnome-calendar" "gnome-font-viewer" "showtime"))))
          (extra-packages
            (fold delete
              (gnome-desktop-configuration-extra-packages (gnome-desktop-configuration))
                (map specification->package
                  '("gucharmap" "system-config-printer" "evince"))))
         (shell
           (fold delete
             (gnome-desktop-configuration-shell (gnome-desktop-configuration))
               (map specification->package
                 '("gnome-bluetooth" "orca" "rygel"))))))


    (service docker-service-type)
    (service containerd-service-type)
    (simple-service 'doas-config
      etc-service-type
        (list (list "doas.conf"
          (plain-file "doas.conf" "permit nopass :wheel\n"))))

    (service zram-device-service-type
      (zram-device-configuration
         (size (* 16 (expt 2 30)))
         (compression-algorithm 'zstd)))

    (service pam-limits-service-type
      (list
        (pam-limits-entry "*" 'both 'nofile 1048576)))

    ;; Modificando os serviços padrões que já vêm no %desktop-services
    (modify-services %desktop-services
;      (gdm-service-type config =>
 ;       (gdm-configuration (inherit config) (wayland? #t)))
      (network-manager-service-type config =>
        (network-manager-configuration (inherit config) (dns "none")))
      (ntp-service-type config =>
        (ntp-configuration
          (inherit config)
          (servers
            (cons (ntp-server
                    (type 'server)
                    (address "br.pool.ntp.org")
                    (options '(iburst (version 4) (maxpoll 16) prefer)))
                  %ntp-servers))))))))
