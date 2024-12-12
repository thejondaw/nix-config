# ❄️ My NixOS Config

## Thinkpad T14 Gen 4

- **Model**: 21HD0072US
- **Memory**: 36GB DDR5
- **Processor**: 12 x 13th Gen Interl(R) Core(TM) i7-1365U
- **Graphics**: Intel Corporation Raptor Lake-P [Iris Xe Graphics](rev 04)
- **Storage**: 1x SSD - 2TB - NVME

- **OS**: NixOS 24.11
- **DE**: GNOME
- **Windowing System**: Wayland

---

## NixOS Disk Layout

- **Disk**: /dev/nvme0n1
- **Partition table**: GPT
- **Root filesystem**: BTRFS (LUKS encrypted)

### Partitions

- **Boot (ESP)**
  - *Size*: 2GB
  - *Type*: FAT32
  - *Mount*: /boot

- **Swap**
  - *Size*: 40GB

- **Root (encrypted)**
  - *Size*: Remaining space
  - *Encryption*: LUKS (Argon2id)
  - *TRIM*: enabled

- **BTRFS Subvolumes**
  - *Compression*: zstd:2
  - *SSD optimized*
  - *Async discard*

```shell
@ -> /
@nix -> /nix
@var -> /var
@varlog -> /var/log
@home -> /home
@snapshots -> /.snapshots
@cache -> /var/cache
```

---

## Installation


```shell
sudo systemctl start wpa_supplicant

wpa_cli
> add_network
> set_network 0 ssid "your_network"
> set_network 0 psk "your_password"
> enable_network 0
> quit

nix-shell -p git

# Download for "disko.nix"
git clone https://github.com/thejondaw/nix-config.git
cd nix-config

mv disko.nix /tmp/

echo -n "password" > /tmp/secret.key

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix

sudo nixos-generate-config --root /mnt

# Setup default settings. Add: "git" "home-manager"
sudo vi /mnt/etc/nixos/configuration.nix

sudo nixos-install

> New password: ***
> Retype new password: *** 

reboot

# As "root"
passwd jondaw
> New password: ***
> Retype new password: *** 

su - jondaw

# Conect via "nmcli" 
nmcli dev wifi list
sudo nmcli dev wifi connect "ИМЯ_СЕТИ" password "ПАРОЛЬ"

# Channels for "Home Manager"
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz home-manager
sudo nix-channel --update

sudo nixos-rebuild switch
```

```shell
# Flatpak Visual Studio Code
flatpak override --user --filesystem=~/.config/git com.visualstudio.code

sudo git config --global user.name "thejondaw"
sudo git config --global user.email "mrjondaw@gmail.com"
```
