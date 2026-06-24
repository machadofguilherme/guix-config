;; modules/graphical/portal.scm
;; Equivalente: modules/graphical/portal.nix
;;
;; XDG Desktop Portal e Flatpak.

(define-module (modules graphical portal)
  #:use-module (gnu services)
  #:use-module (gnu services desktop)
  #:use-module (gnu packages xdisorg)
  #:export (portal-services
            portal-packages))

(define portal-services
  (list
    ;; Flatpak (equivale a services.flatpak.enable = true)
    (service flatpak-service-type)

    ;; XDG Desktop Portal (equivale a xdg.portal.enable = true)
    ;; O portal KDE é incluso automaticamente com plasma-desktop-service-type.
    (service xdg-desktop-portal-service-type)))

(define portal-packages
  (list
    ;; Portal KDE para diálogos de arquivo, etc.
    ;; (pkgs.kdePackages.xdg-desktop-portal-kde)
    xdg-desktop-portal-kde))
