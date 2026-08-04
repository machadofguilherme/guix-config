(define-module (home aliases)
  #:export (fish-aliases fish-abbreviations))

(define fish-aliases
  `(("ls" . "eza")
    ("cat" . "bat")
    ("gs" . "git status")

    ("gx-update"       . "guix pull")
    ("gx-rebuild"      . "doas guix system reconfigure -L $GUIX_CONFIG $GUIX_CONFIG/config.scm")
    ("gx-rebuild-test" . "guix system build -L $GUIX_CONFIG $GUIX_CONFIG/config.scm")
    ("gx-home-rebuild" . "guix home reconfigure -L $GUIX_CONFIG $GUIX_CONFIG/home/home-configuration.scm")
    ("gx-gc"           . "doas guix gc -d 2d")
    ("gx-gc-all"       . "doas guix gc -d 2d -F 10G")

    ("cfg-system"     . "micro $GUIX_CONFIG/config.scm")
    ("cfg-channels"   . "micro $GUIX_CONFIG/channels.scm")
    ("cfg-install"    . "micro $GUIX_CONFIG/my-install.scm")
    ("cfg-boot"       . "micro $GUIX_CONFIG/system/boot.scm")
    ("cfg-doas"       . "micro $GUIX_CONFIG/system/doas.scm")
    ("cfg-filesystem" . "micro $GUIX_CONFIG/system/filesystem.scm")
    ("cfg-packages"   . "micro $GUIX_CONFIG/system/packages.scm")
    ("cfg-services"   . "micro $GUIX_CONFIG/system/services.scm")
    ("cfg-user"       . "micro $GUIX_CONFIG/system/user.scm")

    ("hm-home"      . "micro $GUIX_CONFIG/home/home-configuration.scm")
    ("hm-packages"  . "micro $GUIX_CONFIG/home/packages.scm")
    ("hm-variables" . "micro $GUIX_CONFIG/home/variables.scm")
    ("hm-fish"      . "micro $GUIX_CONFIG/home/fish.scm")
    ("hm-aliases"   . "micro $GUIX_CONFIG/home/aliases.scm")

    ("gxs" . "cd $GUIX_CONFIG && git status")
    ("gxp" . "cd $GUIX_CONFIG && git add -A && git commit && git push")

    ("docker-up"   . "docker compose up -d")
    ("docker-down" . "docker compose down")
    ("steam-cards" . "zen-beta http://localhost:1242")))

(define fish-abbreviations
  `(("gc" . "git commit")
    ("gp" . "git push")))
