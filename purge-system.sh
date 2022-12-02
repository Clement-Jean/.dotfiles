#!/bin/sh
nix-env -p /nix/var/nix/profiles/system --delete-generations old
nix-collect-garbage -d
nix-env -p /nix/var/nix/profiles/system --list-generations
echo "Remove bootloader entries by running: rm /boot/loader/entries/${ENTRY}"
