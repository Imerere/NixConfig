{
  description = "Nixos config flake";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # zaphkiel.url = "github:Rexcrazy804/Zaphkiel";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, home-manager, nur, utils, quickshell, ... } @ inputs:
  {
    nixosConfigurations.pingu = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/pingu/configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };
  };
}
