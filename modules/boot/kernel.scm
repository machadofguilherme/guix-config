;; modules/boot/kernel.scm
;; Equivalente: modules/boot/kernel.nix
;;
;; NixOS usava linuxPackages_cachyos-bore — não existe no Guix.
;; Opções disponíveis:
;;   linux         → kernel padrão (não-livre, via nonguix)
;;   linux-libre   → kernel totalmente livre (padrão Guix)
;;   linux-lts     → versão LTS (via nonguix)
;;
;; Para AMD moderno, recomenda-se 'linux' do canal nonguix
;; pois linux-libre remove firmware blobs necessários para amdgpu completo.

(define-module (modules boot kernel)
  #:use-module (gnu packages linux)       ;; linux-libre
  #:use-module (nongnu packages linux)    ;; linux, linux-lts (requer nonguix)
  #:export (system-kernel
            kernel-extra-arguments
            kernel-initrd-modules
            kernel-sysctl-settings))

;; Kernel escolhido
;; Troque por 'linux-libre' se quiser 100% livre (pode ter problemas com AMD)
(define system-kernel linux)

;; Parâmetros adicionais do kernel (equivale ao segundo boot.kernelParams)
(define kernel-extra-arguments
  (list "amd_pstate=active"
        "acpi_ec_timeout=500"))

;; Módulos carregados no initrd (equivale a boot.initrd.kernelModules)
(define kernel-initrd-modules
  (list "amdgpu"))

;; Configurações sysctl (equivale a boot.kernel.sysctl)
;; Em Guix, sysctl é configurado via sysctl.conf ou serviço específico.
;; Veja o uso em config.scm com 'sysctl-service-type'.
(define kernel-sysctl-settings
  '(("vm.swappiness"                  . "180")
    ("vm.max_map_count"               . "262144")
    ("net.core.default_qdisc"         . "fq")
    ("net.ipv4.tcp_congestion_control" . "bbr")))
