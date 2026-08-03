#!/bin/sh
# guix-enter.sh — chroot num Guix System já instalado, ao estilo do nixos-enter.
#
# Guix (System e Live ISO) não garante /usr/bin/env, só /bin/sh — por isso o
# shebang aponta direto pra /bin/sh em vez de usar env pra achar o bash.
#
# Uso:
#   ./guix-enter.sh                        # abre shell interativo dentro do chroot
#   ./guix-enter.sh -c "guix system reconfigure /mnt-repo/config.scm"
#   ./guix-enter.sh -r /mnt -u guilherme -c "herd status"
#
# Pré-requisito: a raiz do sistema (subvolumes @root, @home, @gnu, EFI) já
# deve estar montada em MOUNTPOINT (padrão /mnt) ANTES de rodar este script.
# Este script cuida só do --rbind de /proc, /sys, /dev, do chroot em si e
# de carregar os perfis do Guix — não faz o mount inicial dos subvolumes.

set -eu

MNT="/mnt"
USER_NAME="guilherme"
COMMAND=""

usage() {
  cat <<EOF
Uso: $(basename "$0") [-r MOUNTPOINT] [-u USUARIO] [-c "comando"]

  -r  Ponto de montagem raiz já montado (padrão: /mnt)
  -u  Usuário cujo perfil (~/.guix-profile) será carregado (padrão: guilherme)
  -c  Comando a executar dentro do chroot. Se omitido, abre shell interativo.
  -h  Mostra esta ajuda.
EOF
  exit 1
}

while getopts "r:u:c:h" opt; do
  case "$opt" in
    r) MNT="$OPTARG" ;;
    u) USER_NAME="$OPTARG" ;;
    c) COMMAND="$OPTARG" ;;
    h) usage ;;
    *) usage ;;
  esac
done

if [ "$(id -u)" -ne 0 ]; then
  echo "erro: rode como root (precisa de chroot/mount)." >&2
  exit 1
fi

if [ ! -d "$MNT/gnu" ] || [ ! -d "$MNT/var/guix" ]; then
  echo "erro: '$MNT' não parece ser a raiz de um Guix System instalado (sem /gnu ou /var/guix)." >&2
  echo "Monte os subvolumes (@root em $MNT, @home, @gnu, EFI) antes de rodar este script." >&2
  exit 1
fi

echo ">> Garantindo que $MNT/proc, $MNT/sys, $MNT/dev existem ..."
mkdir -p "$MNT/proc" "$MNT/sys" "$MNT/dev"

echo ">> Montando /proc, /sys, /dev em $MNT ..."
mount --rbind /proc "$MNT/proc"
mount --rbind /sys  "$MNT/sys"
mount --rbind /dev  "$MNT/dev"

if [ -d /sys/firmware/efi ]; then
  if [ -d "$MNT/boot/efi" ] && ! mountpoint -q "$MNT/boot/efi"; then
    echo "aviso: /boot/efi existe em $MNT mas não está montado." >&2
    echo "       Monte a ESP manualmente se for reinstalar/reparar o GRUB." >&2
  fi
fi

cleanup() {
  echo ">> Desmontando /proc, /sys, /dev de $MNT ..."
  umount -R "$MNT/dev"  2>/dev/null || true
  umount -R "$MNT/sys"  2>/dev/null || true
  umount -R "$MNT/proc" 2>/dev/null || true
}
trap cleanup EXIT

# Script que roda DENTRO do chroot: carrega perfis, sobe um guix-daemon
# mínimo (o daemon do live/ISO não enxerga o store do sistema chrootado
# da forma que precisamos) e então executa o comando pedido ou um shell.
INNER_SCRIPT="
set -e
source /var/guix/profiles/system/profile/etc/profile
[ -f /home/$USER_NAME/.guix-profile/etc/profile ] && source /home/$USER_NAME/.guix-profile/etc/profile
[ -f /home/$USER_NAME/.config/guix/current/etc/profile ] && source /home/$USER_NAME/.config/guix/current/etc/profile

if ! pgrep -x guix-daemon >/dev/null 2>&1; then
  guix-daemon --build-users-group=guixbuild --disable-chroot &
  sleep 1
fi
"

if [ -n "$COMMAND" ]; then
  echo ">> Executando dentro do chroot: $COMMAND"
  chroot "$MNT" /bin/sh -c "$INNER_SCRIPT
$COMMAND"
else
  echo ">> Abrindo shell interativo dentro do chroot (saia com 'exit')."
  chroot "$MNT" /bin/sh -c "$INNER_SCRIPT
exec /bin/sh"
fi
