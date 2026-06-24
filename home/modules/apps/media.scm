;; home/modules/apps/media.scm
;; Equivalente: home/modules/apps/media.nix
;;
;; PACOTES INDISPONÍVEIS NO GUIX:
;;   - spotify          → use Spot (cliente livre) ou Flatpak
;;   - discord-development → não disponível; use 'discord' via nonguix
;;   - stremio          → não disponível; use Jellyfin + cliente Flatpak
;;   - zapzap           → verificar; pode estar disponível como 'zapzap'
;;
;; Para Discord e Spotify via Flatpak (recomendado):
;;   flatpak install flathub com.discordapp.Discord
;;   flatpak install flathub com.spotify.Client

(define-module (home modules apps media)
  #:use-module (gnu packages)
  #:use-module (gnu packages messaging)
  #:use-module (nongnu packages discord)  ;; discord via nonguix
  #:use-module (nongnu packages mozilla)  ;; firefox via nonguix
  #:export (media-packages))

(define media-packages
  (list
    ;; Navegador web (alternativa ao zen-browser que não existe no Guix)
    firefox     ;; ou icecat para versão totalmente livre
    discord

    ;; Cliente de mensagens
    ;; discord está disponível via nonguix como 'discord'
    ;; Para WhatsApp Web:
    ;; element-desktop  ;; cliente Matrix alternativo
    ))

;; Nota: Para Spotify e Discord, use Flatpak após habilitar o serviço flatpak:
;;   flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
;;   flatpak install flathub com.spotify.Client com.discordapp.Discord
