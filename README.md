# GuixOS Configuration

Configuração do sistema GuixOS — convertida a partir de NixOS com estrutura modular equivalente.

## 📁 Estrutura

```
/etc/guix/
├── config.scm                  ← configuração principal do sistema
├── hardware-configuration.scm  ← partições e hardware (ADAPTAR!)
├── channels.scm                ← canais Guix (copiar para ~/.config/guix/)
├── home/
│   ├── home.scm                ← configuração do usuário (guix home)
│   └── modules/
│       ├── apps/
│       │   ├── devtools.scm
│       │   ├── media.scm
│       │   └── utilities.scm
│       ├── git/
│       │   └── default.scm
│       ├── shell/
│       │   ├── aliases.scm
│       │   ├── fish.scm
│       │   └── starship.scm
│       └── system/
│           ├── fonts.scm
│           └── variables.scm
└── modules/
    ├── boot/
    │   ├── boot.scm
    │   └── kernel.scm
    ├── graphical/
    │   ├── base.scm
    │   ├── drivers.scm
    │   ├── environment.scm
    │   └── portal.scm
    ├── lang/
    │   ├── locale.scm
    │   └── timezone.scm
    ├── network/
    │   ├── dns.scm
    │   └── net.scm
    ├── performance/
    │   └── amd-notebook.scm
    ├── security/
    │   ├── sudo.scm
    │   └── ulimit.scm
    ├── services/
    │   ├── audio.scm
    │   ├── docker.scm
    │   ├── print.scm
    │   └── touchpad.scm
    └── system/
        ├── fonts.scm
        ├── gaming.scm
        ├── keyboard.scm
        ├── packages.scm
        ├── shell.scm
        ├── user.scm
        └── zram.scm
```

## 🚀 Instalação

### 1. Configurar canais (PRIMEIRO PASSO)

```bash
mkdir -p ~/.config/guix
cp channels.scm ~/.config/guix/channels.scm
guix pull   # demora na primeira vez (~30-60 min)
hash guix   # atualiza o path
```

### 2. Adaptar hardware-configuration.scm

Descubra seus labels de partição:
```bash
lsblk -o NAME,LABEL,UUID,FSTYPE
```

Edite `hardware-configuration.scm` e substitua:
- `"guix-root"` → label da sua partição raiz
- `"guix-home"` → label da sua partição home
- `"EFI"` → label da sua partição EFI

Ou use UUID em vez de label:
```scheme
(device (uuid "xxxx-xxxx-xxxx-xxxx"))
```

### 3. Copiar para /etc/guix

```bash
sudo mkdir -p /etc/guix
sudo cp -r . /etc/guix/
```

### 4. Aplicar configuração do sistema

```bash
sudo guix system reconfigure /etc/guix/config.scm
```

### 5. Aplicar configuração do home

```bash
guix home reconfigure /etc/guix/home/home.scm
```

## ⚠️ Diferenças do NixOS

### Conceitos equivalentes

| NixOS                          | GuixOS                                      |
|-------------------------------|---------------------------------------------|
| `nixos-rebuild switch`        | `guix system reconfigure`                   |
| `home-manager switch`         | `guix home reconfigure`                     |
| `nix flake update`            | `guix pull`                                 |
| `nix-collect-garbage -d`      | `guix gc --delete-generations=2d`           |
| `/nix/store`                  | `/gnu/store`                                |
| `flake.nix`                   | `channels.scm`                              |
| `configuration.nix`           | `config.scm`                                |
| `home.nix` (Home Manager)     | `home.scm` (guix home)                      |
| `environment.systemPackages`  | `(packages ...)` no `operating-system`      |
| `home.packages`               | `(packages ...)` no `home-environment`      |
| `services.X.enable = true`    | `(service X-service-type)`                  |

### Pacotes não disponíveis

Os seguintes pacotes da sua config NixOS **não existem no Guix**:

| Pacote NixOS              | Alternativa no Guix                          |
|--------------------------|----------------------------------------------|
| `zen-browser`             | `firefox` ou `librewolf`                     |
| `linuxPackages_cachyos-bore` | `linux` (nonguix) ou `linux-libre`        |
| `proton-ge-bin`           | Proton nativo do Steam                       |
| `heroic`                  | `flatpak install flathub com.heroicgameslauncher.hgl` |
| `spotify`                 | `flatpak install flathub com.spotify.Client` |
| `discord-development`     | `discord` via nonguix ou Flatpak             |
| `stremio`                 | Flatpak                                      |
| `vivaldi`                 | `firefox` ou `chromium`                      |
| `archisteamfarm`          | AppImage ou binário manual                   |
| `anime-game-launcher`     | Não disponível                               |
| `nix-heuristic-gc`        | `guix gc` + `guix system delete-generations` |
| `ngrok`                   | `bore` (alternativa livre)                   |
| `postman`                 | `insomnia` ou Bruno                          |
| `vscode`                  | `vscodium` (fork open-source)                |
| `gitmoji-cli`             | `commitizen`                                 |

### plasma-manager

O `plasma-manager` (Home Manager) não tem equivalente direto no Guix Home.
As configurações do KDE Plasma (plasma.nix com painéis, widgets, etc.)
precisam ser feitas manualmente pela interface gráfica do KDE.

Para backups da configuração do KDE:
```bash
# Salvar
cp -r ~/.config/plasma* ~/backup/
cp -r ~/.local/share/plasma ~/backup/

# Restaurar
cp -r ~/backup/plasma* ~/.config/
cp -r ~/backup/plasma ~/.local/share/
```

## 🛠️ Comandos úteis no Guix

```bash
# Buscar pacotes
guix search firefox
guix search --format=recutils firefox | recsel -p name,synopsis

# Instalar pacote temporário (sem salvar no perfil)
guix shell firefox

# Ver gerações do sistema
sudo guix system list-generations

# Ver gerações do home
guix home list-generations

# Rollback do sistema
sudo guix system roll-back

# Informações do sistema
guix system describe
```

## 📚 Recursos

- [Manual do Guix](https://guix.gnu.org/manual/en/)
- [Manual do Guix Home](https://guix.gnu.org/manual/en/html_node/Home-Configuration.html)
- [canal nonguix](https://gitlab.com/nonguix/nonguix) — pacotes não-livres
- [Guix Cookbook](https://guix.gnu.org/cookbook/en/)
