# ❄️ My NixOS Config

```shell
# 1. Клонируем и готовим конфиг
git clone https://github.com/thejondaw/nix-config.git
mkdir nix
cd nixos-config
mv * $HOME/nix # Config is supposed to be in the ~/nix directory
cd ../nix

# 2. Делаем разметку через disko
echo -n "твой_пароль_для_шифрования" > /tmp/secret.key
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko disko.nix

# 3. Генерим базовый hardware-configuration.nix
sudo nixos-generate-config --root /mnt

# 4. Копируем их hardware-configuration.nix в наш конфиг
sudo cp /mnt/etc/nixos/hardware-configuration.nix nixos/

# 5. Теперь можно устанавливать через флейк
sudo nixos-install --flake .#nixos

# 6. После перезагрузки активируем конфиг и home-manager
sudo nixos-rebuild switch --flake .
home-manager switch --flake .
```
