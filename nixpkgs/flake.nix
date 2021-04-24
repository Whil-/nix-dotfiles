{
  description = "Nix flake with Home-Manager from non-nixos system";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  # inputs.nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.emacs-overlay = {
    type = "github";
    owner = "mjlbach";
    repo = "emacs-overlay";
    ref = "feature/flakes";
  };

  inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
    let
      overlays = [
        # nixos-unstable-overlay
        inputs.emacs-overlay.overlay
      ];
    in
    {
      homeConfigurations = {
        linux-wsl2 = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = overlays;
              imports = [
                ./modules/home-manager.nix
                ./modules/cli.nix
                ./modules/git.nix
                ./modules/emacs.nix
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/home/whil";
          username = "whil";
        };
      };
      linux-wsl2 = self.homeConfigurations.linux-wsl2.activationPackage;
    };
}
