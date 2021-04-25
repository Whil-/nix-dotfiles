{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "whil";
  home.homeDirectory = "/home/whil";

  home.packages = with pkgs; [
    fd
    ripgrep
  ];

  xdg.configFile."git/config".text = ''
    [user]
      email = gustav@whil.se
      name = Gustav Wikström
  ''

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  programs.emacs = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.emacsMacport else pkgs.emacsPgtkGcc;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
