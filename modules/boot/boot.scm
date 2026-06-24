;; modules/boot/boot.scm
;; Equivalente: modules/boot/boot.nix + parte de boot.nix
;;
;; NixOS usava systemd-boot; Guix suporta grub-efi-bootloader
;; e também bootloader-configuration com grub-efi-removable.

(define-module (modules boot boot)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:export (bootloader-cfg
            boot-kernel-arguments
            boot-blacklisted-modules))

;; Configuração do bootloader (equivale a boot.loader)
(define bootloader-cfg
  (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets '("/boot/efi"))
    (timeout 3)
    ;; Limita a 3 entradas de geração visíveis (como configurationLimit = 3)
    (menu-entries '())))

;; Parâmetros do kernel passados na linha de comando
;; (equivale a boot.kernelParams)
(define boot-kernel-arguments
  (list "quiet"
        "amdgpu.aspm=0"
        "udev.log_level=3"
        "amdgpu.dcdebugmask=0x10"
        ;; Módulo blacklistado via parâmetro do kernel
        "modprobe.blacklist=amd_sfh"))

;; Referência: não há campo direto de blacklist em Guix;
;; usa-se modprobe.blacklist= nos kernel-arguments (acima).
(define boot-blacklisted-modules
  '("amd_sfh"))
