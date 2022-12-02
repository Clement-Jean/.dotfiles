{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      gcc
      git
      emacs
      wget
      bazel_5
      kubectl
      go_1_19
    ];
    interactiveShellInit = ''
      alias ..='cd ..'
      alias ...='cd ../..'
    '';
  };
}
