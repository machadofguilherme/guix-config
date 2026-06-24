;; modules/system/gaming.scm
;; Equivalente: modules/system/gaming.nix
;;
;; ATENÇÃO — Gaming no Guix é muito mais limitado que no NixOS:
;;
;; DISPONÍVEL via nonguix:
;;   - steam           ✓ (canal nonguix)
;;   - gamemode        ✓
;;   - gamescope       ✓ (pode variar)
;;   - mangohud        ✓
;;   - protontricks    ✓ (verificar disponibilidade)
;;
;; NÃO DISPONÍVEL no Guix:
;;   - proton-ge-bin       → use Proton nativo do Steam ou instale manualmente
;;   - heroic              → não disponível (instale via Flatpak)
;;   - hydralauncher       → não disponível
;;   - faugus-launcher     → não disponível
;;   - lsfg-vk-ui          → não disponível
;;   - protonplus          → não disponível
;;   - vkd3d-proton        → verificar, pode estar no nonguix
;;   - archisteamfarm      → não disponível (instale como AppImage ou binário)
;;   - anime-game-launcher → não disponível
;;
;; ALTERNATIVA RECOMENDADA: Instalar jogadores via Flatpak
;;   flatpak install flathub com.heroicgameslauncher.hgl
;;   flatpak install flathub com.valvesoftware.Steam  (alternativa)

(define-module (modules system gaming)
  #:use-module (gnu packages games)
  #:use-module (gnu packages linux)
  #:use-module (nongnu packages games)    ;; requer nonguix
  #:export (gaming-packages
            gaming-services))

;; Pacotes de gaming disponíveis
(define gaming-packages
  (list
    ;; Steam (via nonguix — requer canal nonguix no channels.scm)
    steam

    ;; GameMode — otimizações automáticas durante jogos
    gamemode

    ;; Gamescope — compositor Wayland para jogos
    gamescope

    ;; mGBA — emulador Game Boy Advance ✓
    mgba

    ;; MangoHud — overlay de performance
    mangohud

    ;; Ferramentas Vulkan
    vulkan-tools
    vulkan-loader))

;; GameMode não requer serviço separado no Guix —
;; é ativado via gamemodrun ou DBUS automaticamente.
(define gaming-services
  '())
