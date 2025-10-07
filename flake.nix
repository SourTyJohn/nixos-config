{
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/release-25.05";  # stable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";  # rolling release

    # For managing /home directory
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For customizing KDE Plasma
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # Global catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    # Nix User Repository
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
      self,
      catppuccin,
      home-manager,
      nixpkgs,
      nur,
      ...
    }@inputs:
    let
      #  /-------------------------/ Settings \----------------------------\
      userConfig = {
        users = {
          nix = {  # username in system
            isNormalUser = true;
            description = "Admin";  # displayed username on lock screen
            extraGroups = [ "networkmanager" "wheel" "docker" "postgres" ];
          };
        };

        home-manager-username = "nix";
        home-manager-home-dir = "/home/nix";
      };
      #  \-------------------------\ --------- /----------------------------/

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };

    in
    {
    
    devShells.x86_64-linux.default = pkgs.mkShell {
      # Tools available in the shell
      buildInputs = [
        pkgs.python312
        pkgs.poetry
        pkgs.pkg-config
        pkgs.libmysqlclient
        pkgs.python312Packages.setuptools
        pkgs.nodejs
        pkgs.libGL
        pkgs.stdenv.cc.cc.lib
      ];

      # Commands to run when the shell starts
      shellHook = ''
        echo "Python development shell"
      '';
    };

    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; inherit userConfig; };
        modules = [
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
    };

    homeConfigurations = {
      default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; inherit userConfig; };
        modules = [
          ./hosts/default/home.nix
          catppuccin.homeModules.catppuccin  # System theme for plasma6
          nur.modules.homeManager.default  # Nix User Repos
        ];
      };
    };
  };
}
