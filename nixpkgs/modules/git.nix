{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    git-lfs
  ];
  home.file.".config/git/ignore".text = ''
    tags
    result
  '';

}
