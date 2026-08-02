;; ==========================================================================
;; Sistemas de arquivos
;; ==========================================================================

(define-module (system filesystem)
  #:use-module (gnu)
  #:export (system-file-systems))

(define system-file-systems
  (cons*
    (file-system
      (mount-point "/")
      (device
        (uuid "ba518bb4-49dd-4841-a649-d4b3f768d9c3"))
      (type "btrfs")
      (options "subvol=@root,compress=zstd"))

    (file-system
      (mount-point "/home")
      (device
        (uuid "ba518bb4-49dd-4841-a649-d4b3f768d9c3"))
      (type "btrfs")
      (options "subvol=@home,compress=zstd"))

    (file-system
      (mount-point "/gnu/store")
      (device
        (uuid "ba518bb4-49dd-4841-a649-d4b3f768d9c3"))
      (type "btrfs")
      (options "subvol=@store,compress=zstd"))

    (file-system
      (mount-point "/boot/efi")
      (device
        (uuid "76A1-906B" 'fat32))
      (type "vfat"))

    %base-file-systems))
