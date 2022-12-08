{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      gcc
      git
      git-crypt
      gnupg
      tree
      emacs
      bazel_5
      kubectl
      go_1_19
      cargo
      rustc
    ];
    interactiveShellInit = ''
      alias ..='cd ..'
      alias ...='cd ../..'
    '';
  };
}
