;; home/modules/system/variables.scm
;; Equivalente: home/modules/system/variables.nix

(define-module (home modules system variables)
  #:use-module (gnu home services)
  #:export (home-variable-services))

;; Equivale a home.sessionVariables do Home Manager
(define home-variable-services
  (list
    (service home-environment-variables-service-type
      '(;; Wayland / Mozilla
        ("MOZ_ENABLE_WAYLAND"         . "1")
        ("NIXOS_OZONE_WL"             . "1")  ;; mantido para compatibilidade

        ;; Editor padrão
        ("EDITOR"                     . "nano")

        ;; AMD / Vulkan
        ("AMD_VULKAN_ICD"             . "RADV")
        ("RADV_PERFTEST"              . "aco")
        ("MESA_LOADER_DRIVER_OVERRIDE" . "radeonsi")
        ("MESA_GL_VERSION_OVERRIDE"   . "4.6")
        ("MESA_GLSL_VERSION_OVERRIDE" . "460")
        ("LIBVA_DRIVER_NAME"          . "radeonsi")

        ;; Gaming
        ("DXVK_ASYNC"                 . "1")
        ("__GL_SHADER_DISK_CACHE"     . "1")
        ("__GL_SHADER_DISK_CACHE_PATH" . "$HOME/.cache/nv-shaders")

        ;; Node.js
        ("NODE_OPTIONS"               . "--max-old-space-size=4096")

        ;; Locale para VSCodium
        ("VSCODE_LOCALE"              . "pt-BR")))))
