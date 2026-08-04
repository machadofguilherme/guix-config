(use-modules (gnu)
             (gnu packages admin)
             (gnu packages ncurses)
             (gnu packages rsync)
             (gnu packages disk)
             (gnu packages version-control)
             ((gnu packages linux) #:select (util-linux))
	     (gnu services sysctl)
             (gnu system)
             (gnu system install)
             (gnu system linux-initrd)
             (nonguix transformations))

((compose (nonguix-transformation-guix #:guix-source? #t)
          (nonguix-transformation-linux #:initrd base-initrd))
 (operating-system
   (inherit installation-os)

   (kernel-arguments
    (append (list "loglevel=1")
           %default-kernel-arguments))

   (services
    (cons (service sysctl-service-type
                    (sysctl-configuration
                     (settings
                      (append '(("net.ipv6.conf.all.disable_ipv6" . "1")
                                ("net.ipv6.conf.default.disable_ipv6" . "1"))
                              %default-sysctl-settings))))
          (operating-system-user-services installation-os)))

   (packages
    (append
     (list ncurses htop rsync parted gptfdisk util-linux git-minimal)
     (operating-system-packages installation-os)))))
