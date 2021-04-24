{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    fd
    ripgrep
  ];

  xdg.configFile."git/config".source = ../configs/git/gitconfig;
}
