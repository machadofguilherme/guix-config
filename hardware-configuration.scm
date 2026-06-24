;; hardware-configuration.scm
;;
;; ATENÇÃO: adapte os labels/UUIDs ao seu sistema real.
;; Para descobrir os labels: lsblk -o NAME,LABEL,UUID,FSTYPE
;;
;; Equivalente ao hardware-configuration.nix do NixOS.

(define-module (hardware-configuration)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:export (system-file-systems
            system-initrd-modules))

;; Módulos necessários no initrd (equivale ao boot.initrd.availableKernelModules)
(define system-initrd-modules
  (list "nvme"
        "xhci_pci"
        "usb_storage"
        "sd_mod"
        "i8042"
        "atkbd"))

;; Sistemas de arquivos
;; Ajuste os LABEL= para corresponder às suas partições reais.
;; Você pode usar (uuid "xxxx-xxxx") em vez de label se preferir.
(define system-file-systems
  (list
    (file-system
      (device (file-system-label "nixos"))
      (mount-point "/")
      (type "btrfs")
      (options "subvol=@root,compress=zstd,space_cache=v2"))

    (file-system
      (device (file-system-label "nixos"))
      (mount-point "/home")
      (type "btrfs")
      (options "subvol=@home,compress=zstd,space_cache=v2"))

    (file-system
      (device (file-system-label "boot"))
      (mount-point "/boot/efi")
      (type "vfat")
      (flags '(boot)))
