;; Este arquivo "home-environment" pode ser passado para 'guix home
;; reconfigure' para reproduzir o conteúdo do seu perfil. Isto é "simbólico":
;; ele apenas especifica nomes de pacotes. Para reproduzir exatamente o mesmo
;; perfil, você também precisa capturar os canais que estão sendo usados,
;; conforme retornado por "guix describe".
;; Veja a seção "Replicando Guix" no manual.

(use-modules (gnu home)
             (gnu home services)
             (gnu home services shells)
             (gnu services)
             (gnu packages)
             (gnu packages admin)
	     (gnu packages node)
             (guix gexp)
	     (gnu home services fontutils))

(home-environment
  ;; Abaixo está a lista de pacotes que aparecerão no seu
  ;; perfil pessoal, em ~/.guix-home/profile.
  (packages (specifications->packages (list "node")))

  ;; Abaixo está a lista de serviços Home. Para procurar por serviços
  ;; disponíveis, execute 'guix home search KEYWORD' em um terminal.
  (services
   (append (list) %base-home-services)))
