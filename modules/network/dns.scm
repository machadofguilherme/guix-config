;; modules/network/dns.scm
;; Equivalente: modules/network/dns.nix
;;
;; DNS via Cloudflare for Families (1.1.1.2 / 1.0.0.2) — sem malware.
;; No Guix, usamos nscd para resolução de nomes.

(define-module (modules network dns)
  #:use-module (gnu services)
  #:use-module (gnu services networking)
  #:use-module (gnu system nss)
  #:export (dns-name-service-switch
            dns-services))

;; Equivale ao services.resolved com DNS = ["1.1.1.2" "1.0.0.2"]
;; Em Guix, o /etc/resolv.conf é gerenciado pelo nscd + NetworkManager.
;; Configure o DNS no NetworkManager ou via arquivo estático abaixo.
(define dns-services
  (list
    ;; nscd — Name Service Cache Daemon
    (service nscd-service-type
      (nscd-configuration
        (caches (list (nscd-cache (database 'hosts)
                                  (positive-time-to-live (* 10 60))
                                  (negative-time-to-live 20))
                      (nscd-cache (database 'passwd)
                                  (positive-time-to-live (* 60 60)))
                      (nscd-cache (database 'group)
                                  (positive-time-to-live (* 60 60)))))))))

;; NSS switch (hosts: files dns) — padrão funcional
(define dns-name-service-switch
  %mdns-host-lookup-nss)

;; Para usar os DNS da Cloudflare (1.1.1.2 / 1.0.0.2), adicione ao
;; /etc/NetworkManager/conf.d/dns.conf após instalação:
;;
;;   [global-dns-domain-*]
;;   servers=1.1.1.2,1.0.0.2
;;   searches=
;;
;; Ou configure via nmcli / nm-applet na interface gráfica.
