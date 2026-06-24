;; modules/lang/locale.scm
;; Equivalente: modules/lang/locale.nix

(define-module (modules lang locale)
  #:export (system-locale
            system-locale-libcs
            system-locale-definitions))

;; Equivale a i18n.defaultLocale = "pt_BR.UTF-8"
(define system-locale "pt_BR.UTF-8")

;; Locales adicionais a gerar (equivale a i18n.extraLocaleSettings)
(define system-locale-definitions
  (list "pt_BR.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"))
