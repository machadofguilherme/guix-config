;; ==========================================================================
;; Pacotes
;; ==========================================================================

(define-module (system packages)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages text-editors)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages docker)
  #:use-module (saayix packages binaries)
  #:export (system-packages))

(define system-packages
  (list
    git
    fish
    nano
    micro
    curl
    wget
    btop
    dbus
    pfetch
    ncurses
    flatpak
    openssh
    keychain
    zen-browser-bin
    opendoas))
