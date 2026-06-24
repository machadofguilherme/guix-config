;; modules/system/zram.scm
;; Equivalente: modules/system/zram.nix
;;
;; ZRAM swap com compressão zstd.
;; Equivale a:
;;   zramSwap.enable = true
;;   zramSwap.algorithm = "zstd"
;;   zramSwap.memoryPercent = 50

(define-module (modules system zram)
  #:use-module (gnu services)
  #:use-module (gnu services linux)
  #:export (zram-services))

(define zram-services
  (list
    (service zram-device-service-type
      (zram-device-configuration
        ;; Tamanho = 50% da RAM (equivale a memoryPercent = 50)
        ;; Ajuste conforme sua RAM: ex. "4G" para 8GB de RAM
        (size "50%")
        ;; Algoritmo de compressão (equivale a algorithm = "zstd")
        (compression-algorithm "zstd")
        ;; Prioridade maior que swap em disco
        (priority 100)))))
