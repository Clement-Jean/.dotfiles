{ config, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./environment.nix
    ./networking.nix
    ./users.nix
  ];

  system.stateVersion = "22.05";
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus32";
    useXkbConfig = true;
  };

  services.xserver = {
    enable = true;
    windowManager.exwm = {
      enable = true;
      enableDefaultConfig = true;
      extraPackages = epkgs: [
        # Tools
        epkgs.org
        epkgs.magit
        epkgs.lsp-mode
        epkgs.yasnippet
        epkgs.docker
        epkgs.bazel

        # Languages
        epkgs.nix-mode
        epkgs.go-mode
        epkgs.rust-mode
        epkgs.protobuf-mode
        epkgs.dockerfile-mode

        # Misc
        epkgs.all-the-icons
      ];
    };
    libinput.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  virtualisation.docker.enable = true;
}
