{ config, pkgs, ... }:
{
  imports = [
    ./hardware.nix
    ./environment.nix
    ./networking.nix
    ./users.nix
  ];

  system.stateVersion = "22.11";
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

  nix.settings.substituters = [
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
  ];

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

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  virtualisation.docker.enable = true;
}
