;; modules/graphical/drivers.scm
;; Equivalente: modules/graphical/drivers.nix
;;
;; Aceleração gráfica AMD (VA-API / VDPAU).
;; No Guix, isso é feito via pacotes instalados no perfil do sistema.

(define-module (modules graphical drivers)
  #:use-module (gnu packages video)
  #:use-module (gnu packages gl)
  #:export (graphics-driver-packages))

;; Equivale a hardware.graphics.extraPackages
;; libva-vdpau-driver e libvdpau-va-gl habilitam VA-API e VDPAU para AMD.
(define graphics-driver-packages
  (list
    ;; Decodificação de vídeo por hardware (VA-API)
    libva
    libva-utils

    ;; Ponte VDPAU → VA-API (para aplicações que usam VDPAU)
    libvdpau-va-gl

    ;; Mesa / OpenGL / Vulkan (geralmente já incluso via %desktop-services)
    mesa
    mesa-utils
    vulkan-tools
    vulkan-loader))
