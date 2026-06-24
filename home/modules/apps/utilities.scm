;; home/modules/apps/utilities.scm
;; Equivalente: home/modules/apps/utilities.nix

(define-module (home modules apps utilities)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages video)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages web)
  #:use-module (gnu packages base)
  #:export (utilities-packages))

;; Equivale ao home.packages da sua utilities.nix
(define utilities-packages
  (list
    ;; CLI utilities
    jq           ;; jq
    tree         ;; tree
    btop         ;; btop
    inxi         ;; inxi
    unzip        ;; unzip
    p7zip        ;; p7zip
    yt-dlp       ;; yt-dlp
    cowsay       ;; cowsay
    ffmpeg       ;; ffmpeg
    killall      ;; killall (procps)
    lm-sensors   ;; lm_sensors

    ;; Nota: kamoso (webcam KDE) provavelmente disponível via kdePackages
    ;; Nota: zapzap — verificar se disponível no Guix
    ))
