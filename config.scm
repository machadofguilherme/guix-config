;; config.scm — Configuração principal do sistema GuixOS
;; Equivalente: configuration.nix + flake.nix do NixOS
;;
;; Para aplicar:
;;   sudo guix system reconfigure /etc/guix/config.scm
;;
;; Coloque este arquivo e a pasta modules/ em /etc/guix/

;; Adiciona o diretório atual ao load path para encontrar os módulos locais
(add-to-load-path (dirname (current-filename)))

(use-modules
  ;; Guix padrão
  (gnu)
  (gnu system)
  (gnu system nss)
  (gnu system keyboard)
  (gnu system shadow)
  (gnu bootloader)
  (gnu bootloader grub)
  (gnu packages base)
  (gnu packages linux)
  (gnu packages shells)
  (gnu services)
  (gnu services desktop)
  (gnu services networking)
  (gnu services sound)
  (gnu services docker)
  (gnu services linux)
  (gnu services sddm)
  (gnu services admin)
  (nongnu packages linux)      ;; kernel não-livre (requer nonguix)
  (nongnu system linux-initrd) ;; microcode AMD/Intel (requer nonguix)

  ;; Módulos locais — hardware
  (hardware-configuration)

  ;; Módulos locais — sistema
  (modules boot boot)
  (modules boot kernel)
  (modules graphical drivers)
  (modules graphical environment)
  (modules graphical portal)
  (modules lang locale)
  (modules lang timezone)
  (modules network net)
  (modules network dns)
  (modules performance amd-notebook)
  (modules security sudo)
  (modules security ulimit)
  (modules services audio)
  (modules services docker)
  (modules services print)
  (modules system fonts)
  (modules system gaming)
  (modules system keyboard)
  (modules system packages)
  (modules system shell)
  (modules system user)
  (modules system zram))

(operating-system
  ;; ── Identidade ────────────────────────────────────────────────────────────
  (host-name system-hostname)      ;; "GuixOS" — definido em modules/network/net.scm
  (timezone system-timezone)       ;; "America/Sao_Paulo"
  (locale   system-locale)         ;; "pt_BR.UTF-8"

  (locale-definitions
    (map make-locale-definition system-locale-definitions))

  ;; ── Teclado ───────────────────────────────────────────────────────────────
  ;; Layout ABNT2 para console e X11
  (keyboard-layout system-keyboard)  ;; (keyboard-layout "br" "abnt2")

  ;; ── Kernel ────────────────────────────────────────────────────────────────
  ;; linux do canal nonguix (melhor suporte AMD)
  ;; Troque por 'linux-libre' se quiser 100% livre
  (kernel system-kernel)

  ;; Parâmetros do kernel combinados dos módulos boot e kernel
  (kernel-arguments
    (append boot-kernel-arguments
            kernel-extra-arguments))

  ;; ── Initrd ────────────────────────────────────────────────────────────────
  ;; Módulos disponíveis no disco de RAM inicial
  (initrd-modules
    (append system-initrd-modules
            kernel-initrd-modules
            %base-initrd-modules))

  ;; Microcode AMD (requer canal nonguix)
  ;; Equivale a hardware.cpu.amd.updateMicrocode = true
  (initrd microcode-initrd)
  (firmware (list amd-microcode))   ;; ou intel-microcode para Intel

  ;; ── Bootloader ────────────────────────────────────────────────────────────
  (bootloader bootloader-cfg)   ;; grub-efi-bootloader em /boot/efi, timeout=3

  ;; ── Sistemas de Arquivo ───────────────────────────────────────────────────
  ;; Definidos em hardware-configuration.scm — adapte os labels/UUIDs!
  (file-systems
    (append system-file-systems
            %base-file-systems))

  ;; ── Usuários ──────────────────────────────────────────────────────────────
  (users (append system-users %base-user-accounts))
  (groups (append system-groups %base-groups))

  ;; ── Pacotes do Sistema ────────────────────────────────────────────────────
  ;; (disponíveis para todos os usuários)
  (packages
    (append
      system-font-packages
      graphics-driver-packages
      system-extra-packages
      shell-packages
      gaming-packages
      %base-packages))

  ;; ── Serviços ──────────────────────────────────────────────────────────────
  (services
    (append
      ;; Rede
      network-services
      dns-services

      ;; Gráfico
      desktop-environment-services
      portal-services

      ;; Hardware
      audio-services
      print-services
      zram-services
      performance-services

      ;; Docker
      docker-services

      ;; Configuração de sudo e limites
      sudo-services

      ;; Sysctl (equivale a boot.kernel.sysctl)
      (list
        (service sysctl-service-type
          (sysctl-configuration
            (settings kernel-sysctl-settings))))

      ;; Limites de arquivos abertos (/etc/security/limits.conf)
      (list
        (extra-special-file
          "/etc/security/limits.conf"
          (plain-file "limits.conf"
            "*    -    nofile    1048576\nroot -    nofile    1048576\n")))

      ;; Serviços base do desktop (dbus, polkit, elogind, upower, etc.)
      ;; %desktop-services já inclui muitos serviços essenciais
      %desktop-services))

  ;; ── NSS (resolução de nomes) ──────────────────────────────────────────────
  (name-service-switch dns-name-service-switch))
