;; home/modules/shell/starship.scm
;; Equivalente: home/modules/shell/starship.nix
;;
;; Prompt Starship com o mesmo tema verde da sua config original.

(define-module (home modules shell starship)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu packages shells)
  #:export (starship-services))

;; Conteúdo do starship.toml (mesmo tema da sua config NixOS)
(define starship-toml
  "[character]
success_symbol = ""
error_symbol = ""

format = """
[](#2E7D32)$os$username[](bg:#4CAF50 fg:#2E7D32)$directory[](fg:#4CAF50 bg:#8BC34A)$git_branch$git_status[](fg:#8BC34A bg:#A2D149)$nodejs$rust$golang[](fg:#A2D149 bg:#06969A)$docker_context[](fg:#06969A bg:#33658A)$time[ ](fg:#33658A)"""

[username]
show_always = true
style_user = "bg:#2E7D32"
style_root = "bg:#2E7D32"
format = "[$user ]($style)"

[directory]
style = "bg:#4CAF50"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
symbol = ""
style = "bg:#8BC34A"
format = "[ $symbol $branch ]($style)"

[git_status]
style = "bg:#8BC34A"
format = "[$all_status$ahead_behind ]($style)"

[nodejs]
style = "bg:#A2D149"
format = "[ $symbol ($version) ]($style)"

[rust]
style = "bg:#A2D149"
format = "[ $symbol ($version) ]($style)"

[golang]
style = "bg:#A2D149"
format = "[ $symbol ($version) ]($style)"

[docker_context]
style = "bg:#06969A"
format = "[ $symbol $context ]($style)"

[time]
disabled = false
style = "bg:#33658A"
format = "[ ♥ $time ]($style)"
time_format = "%H:%M"
")

(define starship-services
  (list
    ;; Instala o starship.toml em ~/.config/starship.toml
    (simple-service 'starship-config
      home-xdg-configuration-files-service-type
      (list
        `("starship.toml"
          ,(plain-file "starship.toml" starship-toml))))

    ;; Adiciona inicialização do starship no fish
    (service home-fish-service-type
      (home-fish-configuration
        (config
          (list
            (plain-file "starship-init.fish"
              "# Starship prompt\nstarship init fish | source\n")))))))
