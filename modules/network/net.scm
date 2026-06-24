;; modules/network/net.scm
;; Equivalente: modules/network/net.nix

(define-module (modules network net)
  #:use-module (gnu services)
  #:use-module (gnu services networking)
  #:use-module (gnu packages networking)
  #:export (network-services
            system-hostname))

(define system-hostname "GuixOS")

(define network-services
  (list
    ;; NetworkManager (equivale a networking.networkmanager.enable = true)
    (service network-manager-service-type
      (network-manager-configuration
        ;; wifi.powersave = false
        (dns "default")))

    ;; WPA Supplicant necessário para o NetworkManager funcionar
    (service wpa-supplicant-service-type)

    ;; NTP / sincronização de tempo (equivale a services.timesyncd.enable)
    (service ntp-service-type)))

;; Nota: Bluetooth desabilitado (hardware.bluetooth.enable = false)
;; Não adicionar bluetooth-service-type aqui.
;;
;; Nota: IPv6 pode ser desabilitado via sysctl:
;;   ("net.ipv6.conf.all.disable_ipv6" . "1")
;; Adicione em kernel-sysctl-settings se necessário.
