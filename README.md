# .dotfiles

## Steps

1) `git submodule init`
2) `git submodule update`
3) `ln -s ~/.dotfiles/.emacs ~/.emacs`
4) `ln -s ~/.dotfiles/.emacs.d ~/.emacs.d`
5) `ln -s ~/.dotfiles/.emacs.d/protobuf-snippets/protobuf-fn ~/.dotfiles/.emacs.d/lisp/protobuf-fn`
6) `ln -s ~/.dotfiles/.emacs.d/protobuf-snippets/protobuf-mode ~/.dotfiles/.emacs.d/snippets/protobuf-mode`
7) create `system/users.nix`:
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
8) create `system/networking.nix`:
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
9) copy /etc/nixos/hardware-configuration.nix to `system/hardware.nix`
10) `./update-system.sh`
11) `./apply-system.sh`
12) `./purge-system.sh` (/!\ this will delete the old nixos generations)
