{
  #inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/8704039c9876b5dc938f76bf895f9f5e61afc68c";

  outputs = { self, nixpkgs }: {

    nixosConfigurations.novena = nixpkgs.lib.nixosSystem {
      system = "armv7l-linux";
      #modules = [ ./configuration.nix ];
      modules = [ ./with-cross.nix ];
    };

    #defaultPackage.x86_64-linux = (import nixpkgs { system = "x86_64-linux"; }).pkgs.hello;

  };

}
