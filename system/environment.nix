{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      gcc
      git
      git-crypt
      gnupg
      emacs
      wget
      bazel_5
      kubectl
      go_1_19
      rustup
    ];
    interactiveShellInit = ''
      alias ..='cd ..'
      alias ...='cd ../..'
    '';
  };
}
