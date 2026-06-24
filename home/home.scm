;; home/home.scm
;; Equivalente: home/home.nix (Home Manager)
;;
;; Configuração do Guix Home — substituto do Home Manager.
;;
;; Para aplicar:
;;   guix home reconfigure /etc/guix/home/home.scm
;;
;; Documentação: https://guix.gnu.org/manual/en/html_node/Home-Configuration.html

(add-to-load-path (dirname (dirname (current-filename))))

(use-modules
  (gnu home)
  (gnu home services)
  (gnu home services shells)
  (gnu home services dotfiles)
  (gnu packages)
  ;; Módulos locais
  (home modules git default)
  (home modules shell fish)
  (home modules shell aliases)
  (home modules shell starship)
  (home modules apps devtools)
  (home modules apps media)
  (home modules apps utilities)
  (home modules system variables)
  (home modules system fonts))

(home-environment
  ;; Pacotes do usuário (equivale a home.packages no Home Manager)
  (packages
    (append
      devtools-packages
      media-packages
      utilities-packages
      home-font-packages))

  ;; Serviços do ambiente home
  (services
    (append
      git-services
      fish-services
      aliases-services
      starship-services
      home-variable-services
      (list
        ;; Cria o diretório de cache para shaders
        (simple-service 'create-shader-cache
          home-files-service-type
          '())))))
