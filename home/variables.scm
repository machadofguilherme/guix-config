;; ==========================================================================
;; Variáveis de ambiente
;; ==========================================================================

(define-module (home variables)
  #:export (home-global-variables))

(define home-global-variables
  `(("EDITOR" . "micro")
    ("PAGER" . "less")
    ("LESSHISTFILE" . "$XDG_CACHE_HOME/lesshst")
    ("GUIX_CONFIG" . "/etc/guix")

    ;; Wayland / Mesa / RADV (APU Renoir)
    ("MOZ_ENABLE_WAYLAND" . "1")
    ("AMD_VULKAN_ICD" . "RADV")
    ("RADV_PERFTEST" . "aco")
    ("MESA_LOADER_DRIVER_OVERRIDE" . "radeonsi")
    ("MESA_GL_VERSION_OVERRIDE" . "4.6")
    ("MESA_GLSL_VERSION_OVERRIDE" . "460")
    ("LIBVA_DRIVER_NAME" . "radeonsi")
    ("DXVK_ASYNC" . "1")

    ("VSCODE_LOCALE" . "pt-BR")
    ("NODE_OPTIONS" . "--max-old-space-size=4096")))
