# .dotfiles

## Steps

1) `ln -s ~/.dotfiles/.emacs ~/.emacs`
2) `ln -s ~/.dotfiles/.emacs.d ~/.emacs.d`
3) create `system/users.nix`:
```
{ pkgs, ... }:
{
  users.users.my_user = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # sudo
      # other groups (eg: docker)
    ];
    packages = with pkgs; [
      # user packages
    ];
  };
}
```
4) create `system/networking.nix`:
```
{ ... }:
{
  networking = {
    hostName = "...";
    defaultGateway = "...";
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    # etc...
  };
}
```
5) copy /etc/nixos/hardware-configuration.nix to `system/hardware.nix`
6) `./update-system.sh`
7) `./apply-system.sh`
8) `./purge-system.sh` (/!\ this will delete the old nixos generations)
