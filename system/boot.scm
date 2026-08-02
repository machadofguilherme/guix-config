;; ==========================================================================
;; Boot (bootloader, kernel, initrd, firmware)
;; ==========================================================================

(define-module (system boot)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu packages firmware)
  #:export (system-bootloader
            system-kernel
            system-initrd
            system-firmware))

(define system-bootloader
  (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets
      '("/boot/efi"))))

(define system-kernel linux)
(define system-initrd microcode-initrd)
(define system-firmware (list linux-firmware amd-microcode))
