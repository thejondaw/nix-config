# ❄️ My NixOS Config

```shell
sudo systemctl start wpa_supplicant

wpa_cli
> add_network
> set_network 0 ssid "твоя_сеть"
> set_network 0 psk "твой_пароль"
> enable_network 0
> quit

nix-shell -p git fish

fish

# Качаю просто ради своего disko.nix
git clone https://github.com/thejondaw/nix-config.git
cd nix-config

mv disko.nix /tmp/

echo -n "password" > /tmp/secret.key

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix

sudo nixos-generate-config --root /mnt

# Добавляем базовые настройки. Добавить: git home-manager
sudo vi /mnt/etc/nixos/configuration.nix

sudo nixos-install

> New password: ***
> Retype new password: *** 

reboot

# Like "root"
passwd jondaw
> New password: ***
> Retype new password: *** 

su - jondaw

# Подключаемся через nmcli 
nmcli dev wifi list
sudo nmcli dev wifi connect "ИМЯ_СЕТИ" password "ПАРОЛЬ"

# Если надо обновить
sudo nixos-rebuild switch
```
