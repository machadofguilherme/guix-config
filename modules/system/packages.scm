;; modules/system/packages.scm
;; Equivalente: modules/system/packages.nix
;;
;; Pacotes instalados no sistema (disponíveis para todos os usuários).
;; Equivale a environment.systemPackages.
;;
;; PACOTES NÃO DISPONÍVEIS NO GUIX (da sua config original):
;;   - zen-browser          → use firefox ou librewolf
;;   - twintaillauncher     → não disponível
;;   - nix-heuristic-gc    → específico do Nix
;;   - nix-prefetch-github → específico do Nix
;;   - cachix               → específico do Nix
;;   - bubblewrap           → disponível como 'bubblewrap' ✓
;;   - kvantum              → disponível como 'kvantum' no Guix

(define-module (modules system packages)
  #:use-module (gnu packages)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages vulkan)
  #:use-module (gnu packages sandbox)
  #:use-module (gnu packages kde)
  #:export (system-extra-packages))

(define system-extra-packages
  (list
    ;; Equivale ao environment.systemPackages da sua config
    unzip            ;; unrar não está disponível; unzip como alternativa
    p7zip
    bubblewrap       ;; bubblewrap
    vulkan-tools     ;; vulkan-tools
    kvantum          ;; kdePackages.qtstyleplugin-kvantum

    ;; Ferramentas de sistema
    openssh
    keychain         ;; SSH keychain

    ;; Nota: anime-game-launcher não existe no Guix
    ))
