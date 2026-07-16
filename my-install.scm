(use-modules (gnu)
             (gnu packages admin)
             (gnu packages ncurses)
             (gnu packages rsync)
             (gnu packages disk)
             (gnu packages version-control)
             ((gnu packages linux) #:select (util-linux))
             (gnu system)
             (gnu system install)
             (gnu system linux-initrd)
             (nonguix transformations))

((compose (nonguix-transformation-guix #:guix-source? #t)
          (nonguix-transformation-linux #:initrd base-initrd))
 (operating-system
   (inherit installation-os)
   (packages
    (append
     (list ncurses htop rsync parted gptfdisk util-linux git-minimal)
     (operating-system-packages installation-os)))))
