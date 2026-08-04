;; ==========================================================================
;; Boot (bootloader, kernel, initrd, firmware)
;; ==========================================================================

(define-module (system boot)
  #:use-module (gnu system)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu packages firmware)
  #:export (system-bootloader
            system-kernel
            system-initrd
            system-firmware
            system-kernel-arguments))

(define system-bootloader
  (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (timeout 3)
    (targets
      '("/boot/efi"))))

(define system-kernel linux)
(define system-initrd microcode-initrd)
(define system-firmware (list linux-firmware amd-microcode))
(define system-kernel-arguments (append (list "ipv6.disable=1" "loglevel=1") %default-kernel-arguments))
