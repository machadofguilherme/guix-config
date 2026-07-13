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
  (gnu)

  ;; Sistema
  (gnu system)
  (gnu system keyboard)

  ;; Kernel + firmware não-livres (Nonguix)
  (nongnu packages linux)
  (nongnu system linux-initrd)

  ;; Boot
  (gnu bootloader)
  (gnu bootloader grub)

  ;; Serviços
  (gnu services)
  (gnu services linux)

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
  (gnu packages text-editors)
  (gnu packages wget)
  (gnu packages curl))

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
      (shell fish)

      ;; Grupos suplementares.
      (supplementary-groups
        '("wheel"
          "netdev"
          "audio"
          "video"
          "kvm")))

    %base-user-accounts))

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
      (options "subvol=@root,noatime,discard=async"))

    (file-system
      (mount-point "/home")
      (device
        (uuid "ba518bb4-49dd-4841-a649-d4b3f768d9c3"))
      (type "btrfs")
      (options "subvol=@home,noatime,discard=async"))

    (file-system
      (mount-point "/gnu/store")
      (device
        (uuid "ba518bb4-49dd-4841-a649-d4b3f768d9c3"))
      (type "btrfs")
      (options "subvol=@store,noatime,discard=async"))

    (file-system
      (mount-point "/boot/efi")
      (device
        (uuid "CB1A-8ADC" 'fat32))
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
    (service gnome-desktop-service-type)
    (service zram-device-service-type
      (zram-device-configuration
         (size (* 16 (expt 2 30)))
         (compression-algorithm 'zstd)))
    (modify-services %desktop-services
      (gdm-service-type config =>
        (gdm-configuration (inherit config) (wayland? #t)))
      (network-manager-service-type config =>
        (network-manager-configuration (inherit config) (dns "none")))))))
