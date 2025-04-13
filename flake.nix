{
  description = "systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      nix-darwin,
      home-manager,
      neovim-nightly-overlay,
      zen-browser,
    }:
    {
      nixosConfigurations = {
        envy = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./envy/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                backupFileExtension = "~";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.erik = import ./envy/home.nix;
                extraSpecialArgs = {
                  inherit neovim-nightly-overlay;
                  inherit nixpkgs-stable;
                  inherit zen-browser;
                };
              };
            }
          ];
        };
      };
      darwinConfigurations = {
        air = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./air/configuration.nix
            ./air/system.nix
            home-manager.darwinModules.home-manager
            {

              home-manager = {
                backupFileExtension = "~";
                useGlobalPkgs = true;
                useUserPackages = true;
                users.erik = import ./air/home.nix;
                extraSpecialArgs = {
                  inherit neovim-nightly-overlay;
                };
              };
            }
          ];
        };
      };
    };
}
