(use-modules
  (gnu)
  (gnu system nss)
  (gnu packages gnome)
  (gnu packages web-browsers)
  (gnu packages package-management)
  (nongnu packages linux)
  (nongnu system linux-initrd))

(use-service-modules
  desktop
  networking
  xorg
  dbus)

(operating-system
  (host-name "guixos")
  (timezone "America/Sao_Paulo")
  (locale "pt_BR.UTF-8")

  (keyboard-layout
    (keyboard-layout "br" "abnt2"))

  ;; Kernel proprietário do Nonguix
  (kernel linux)
  (initrd microcode-initrd)
  (firmware (list linux-firmware))

  (bootloader
    (bootloader-configuration
      (bootloader grub-efi-bootloader)
      (targets '("/boot/efi"))
      (keyboard-layout
        (keyboard-layout "br" "abnt2"))))

  (file-systems
    (append
      (list
        (file-system
          (device (file-system-label "nixos"))
          (mount-point "/")
          (type "btrfs")
          (options "subvol=@root,compress=zstd"))

        (file-system
          (device (file-system-label "nixos"))
          (mount-point "/home")
          (type "btrfs")
          (options "subvol=@home,compress=zstd"))

        (file-system
          (device (file-system-label "boot"))
          (mount-point "/boot/efi")
          (type "vfat")))

      %base-file-systems))

  (users
    (cons
      (user-account
        (name "guilherme")
        (comment "Guilherme Machado")
        (group "users")
        (home-directory "/home/guilherme")
        (supplementary-groups
          '("wheel"
            "netdev"
            "audio"
            "video"
            "input")))

      %base-user-accounts))

  (packages
    (append
      (list
        firefox
        flatpak
        gvfs)

      %base-packages))

  (services
    (append
      (list
        (service gnome-desktop-service-type)
        (service gdm-service-type)
        (service flatpak-service-type))

      %desktop-services))

  (name-service-switch %mdns-host-lookup-nss))
