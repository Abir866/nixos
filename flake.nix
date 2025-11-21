{
  description = "Abir866/nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      userConfig =
        let
          nickname = "Toufiq";
          username = "tufan";
          hostname = "noobstation";
          home = "/home/${username}";
        in
        {
          inherit nickname;
          inherit username;
          inherit hostname;
          inherit home;
          locale = "en_CA.UTF-8";
          timezone = "America/Halifax";
          nixos = "${home}/.config/nixos";
          system = "x86_64-linux";
        };
      moduleArgs = {
        inherit inputs;
        inherit userConfig;
      };
    in
    {
      homeConfigurations.${userConfig.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${userConfig.system};
        modules = [ ./home.nix ];
        extraSpecialArgs = moduleArgs;
      };

      nixosConfigurations.${userConfig.hostname} = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix ];
        specialArgs = moduleArgs;
      };
    };
}
