(define-module (home packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages fonts)
  #:use-module (nongnu packages fonts)
  #:use-module (nongnu packages game-client)
  #:use-module (gnu packages video)
  #:use-module (gnu packages games)
  #:use-module (gnu packages node)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages kde-multimedia)
  #:use-module (gnu packages shellutils)
  #:use-module (gnu packages compression)
  #:use-module (px packages editors)
  #:use-module (px packages networking)
  #:use-module (px packages tools)
  #:export (home-packages))

(define home-packages
  (list
   bat eza bun yt-dlp tree inxi #;ngrok
   cowsay unzip vscode starship steam node haruna
   font-nerd-fira-code font-jetbrains-mono font-google-noto-sans-cjk
   font-google-roboto-mono font-google-roboto font-open-sans
   font-ubuntu-sans font-ubuntu-sans-mono font-dina
   font-google-noto-emoji font-google-noto font-meslo-lg))
