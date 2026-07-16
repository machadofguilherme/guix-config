#!/bin/sh
# ==============================================================================
# setuuid.sh
#
# Detecta o UUID da partição Btrfs (root/home/store) e da partição EFI (vfat)
# e substitui os valores antigos no config.scm pelos UUIDs reais do disco.
#
# Uso:
#   ./setuuid.sh /caminho/para/config.scm
#
# Sem argumento, assume ./config.scm no diretório atual.
#
# IMPORTANTE: rode isso DEPOIS de particionar e formatar os discos
# (mkfs.btrfs, mkfs.vfat), mas ANTES do 'guix system init'.
# ==============================================================================

set -eu

CONFIG_FILE="${1:-./config.scm}"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Erro: arquivo '$CONFIG_FILE' não encontrado." >&2
    exit 1
fi

if ! command -v blkid >/dev/null 2>&1; then
    echo "Erro: 'blkid' não encontrado. Ele vem do util-linux." >&2
    exit 1
fi

if ! command -v lsblk >/dev/null 2>&1; then
    echo "Erro: 'lsblk' não encontrado. Ele vem do util-linux." >&2
    exit 1
fi

echo "==> Dispositivos de bloco detectados:"
lsblk -o NAME,FSTYPE,SIZE,UUID,MOUNTPOINT
echo

# ------------------------------------------------------------------------------
# Detecta a partição Btrfs (assume uma única partição Btrfs com múltiplos
# subvolumes @root, @home, @store).
# ------------------------------------------------------------------------------
BTRFS_DEVICES=$(lsblk -rno NAME,FSTYPE | awk '$2 == "btrfs" {print "/dev/"$1}')
BTRFS_COUNT=$(echo "$BTRFS_DEVICES" | grep -c . || true)

if [ "$BTRFS_COUNT" -eq 0 ]; then
    echo "Erro: nenhuma partição Btrfs encontrada." >&2
    exit 1
elif [ "$BTRFS_COUNT" -gt 1 ]; then
    echo "Mais de uma partição Btrfs encontrada:"
    echo "$BTRFS_DEVICES"
    printf "Digite o dispositivo correto (ex: /dev/nvme0n1p2): "
    read -r BTRFS_DEV
else
    BTRFS_DEV="$BTRFS_DEVICES"
fi

# ------------------------------------------------------------------------------
# Detecta a partição EFI (vfat/fat32).
# ------------------------------------------------------------------------------
EFI_DEVICES=$(lsblk -rno NAME,FSTYPE | awk '$2 == "vfat" {print "/dev/"$1}')
EFI_COUNT=$(echo "$EFI_DEVICES" | grep -c . || true)

if [ "$EFI_COUNT" -eq 0 ]; then
    echo "Erro: nenhuma partição EFI (vfat) encontrada." >&2
    exit 1
elif [ "$EFI_COUNT" -gt 1 ]; then
    echo "Mais de uma partição vfat encontrada:"
    echo "$EFI_DEVICES"
    printf "Digite o dispositivo correto (ex: /dev/nvme0n1p1): "
    read -r EFI_DEV
else
    EFI_DEV="$EFI_DEVICES"
fi

BTRFS_UUID=$(blkid -s UUID -o value "$BTRFS_DEV")
EFI_UUID=$(blkid -s UUID -o value "$EFI_DEV")

if [ -z "$BTRFS_UUID" ]; then
    echo "Erro: não foi possível obter o UUID de $BTRFS_DEV." >&2
    exit 1
fi

if [ -z "$EFI_UUID" ]; then
    echo "Erro: não foi possível obter o UUID de $EFI_DEV." >&2
    exit 1
fi

echo
echo "==> Partição Btrfs : $BTRFS_DEV  (UUID: $BTRFS_UUID)"
echo "==> Partição EFI   : $EFI_DEV  (UUID: $EFI_UUID)"
echo

# ------------------------------------------------------------------------------
# Localiza os UUIDs atualmente escritos no config.scm.
# Formato esperado:
#   (uuid "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")   -> Btrfs
#   (uuid "XXXX-XXXX" 'fat32)                        -> EFI
# ------------------------------------------------------------------------------
OLD_BTRFS_UUID=$(grep -oE '\(uuid "[0-9a-fA-F-]{36}"\)' "$CONFIG_FILE" | head -1 | grep -oE '[0-9a-fA-F-]{36}' || true)
OLD_EFI_UUID=$(grep -oE '\(uuid "[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}" .fat32\)' "$CONFIG_FILE" | head -1 | grep -oE '[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}' || true)

if [ -z "$OLD_BTRFS_UUID" ]; then
    echo "Aviso: não encontrei um UUID de 36 caracteres (Btrfs) no arquivo." >&2
fi

if [ -z "$OLD_EFI_UUID" ]; then
    echo "Aviso: não encontrei um UUID no formato EFI (XXXX-XXXX) no arquivo." >&2
fi

echo "==> No config.scm:"
echo "    UUID Btrfs atual : ${OLD_BTRFS_UUID:-<não encontrado>}"
echo "    UUID EFI atual   : ${OLD_EFI_UUID:-<não encontrado>}"
echo

printf "Confirma a substituição pelos UUIDs reais acima? [s/N] "
read -r CONFIRM
case "$CONFIRM" in
    s|S|y|Y) ;;
    *) echo "Cancelado."; exit 0 ;;
esac

BACKUP_FILE="${CONFIG_FILE}.bak.$(date +%Y%m%d%H%M%S)"
cp "$CONFIG_FILE" "$BACKUP_FILE"
echo "==> Backup salvo em: $BACKUP_FILE"

if [ -n "$OLD_BTRFS_UUID" ]; then
    sed -i "s/${OLD_BTRFS_UUID}/${BTRFS_UUID}/g" "$CONFIG_FILE"
fi

if [ -n "$OLD_EFI_UUID" ]; then
    sed -i "s/${OLD_EFI_UUID}/${EFI_UUID}/g" "$CONFIG_FILE"
fi

echo "==> config.scm atualizado com sucesso."
echo
echo "==> Linhas de UUID resultantes:"
grep -n 'uuid' "$CONFIG_FILE" || true
