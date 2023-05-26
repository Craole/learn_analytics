{
  description = "Data Analytics Portfolio Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  outputs = { self, nixpkgs, flake-utils, rust-overlay, nix-vscode-extensions, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [
        (import rust-overlay)
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config = {
          allowUnfree = true;
          allowAliases = true;
        };
      };
      vscodeExtensions = with pkgs.vscode-extensions; [
        matklad.rust-analyzer
        # eamodio.gitlens
        bbenoist.nix
        vadimcn.vscode-lldb
        tamasfe.even-better-toml
      ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "roc-lang-support";
            publisher = "benjamin-thomas";
            version = "0.0.4";
            # keep this sha for the first run, nix will tell you the correct one to change it to
            sha256 = "sha256-mabNegZ+XPQ6EIHFk6jz2mAPLHAU6Pm3w0SiFB7IE+s=";
          }
        ];

    in {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          #/> Rust <\#
          rust-bin
          openssl
          pkg-config
          cargo-edit
          cargo-watch
          cargo-generate
          rust-script

          #/> Data <\#
          postgresql_15
          sqlx-cli
          # surrealdb
          grafana

          #/> Tools <\#
          pkgs.vscode
          (pkgs.vscode-extensions.withExtensions vscodeExtensions)
          exa
          ripgrep
          # jupyter
          # evcxr
          gnome.seahorse
          gnome.gnome-keyring
          gnome.libgnome-keyring
        ];
      };
    });
}

