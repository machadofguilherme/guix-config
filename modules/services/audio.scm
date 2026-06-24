;; modules/services/audio.scm
;; Equivalente: modules/services/audio.nix
;;
;; PipeWire com compatibilidade ALSA e PulseAudio.

(define-module (modules services audio)
  #:use-module (gnu services)
  #:use-module (gnu services sound)
  #:export (audio-services))

(define audio-services
  (list
    ;; PipeWire (equivale a services.pipewire.enable = true)
    (service pipewire-service-type)

    ;; Compatibilidade PulseAudio via PipeWire
    ;; (equivale a services.pipewire.pulse.enable = true)
    (service pipewire-pulse-service-type)

    ;; RTKit para prioridade em tempo real
    ;; (equivale a security.rtkit.enable = true)
    (service rtkit-daemon-service-type)))
