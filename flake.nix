{
  description = "Data Analytics Portfolio Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
    nix-vscode-extensions,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      overlays = [
        (import rust-overlay)
        (self: super: {
          rustToolchain = super.rust-bin.fromRustupToolchainFile ./rust-toolchain;
        })
      ];
      pkgs = import nixpkgs {inherit system overlays;};
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          #/> Rust <\#
          rustToolchain
          openssl
          pkg-config
          cargo-edit
          cargo-watch
          cargo-generate
          rust-script

          #/> Data <\#
          postgresql_15
          sqlx-cli
#          surrealdb
          grafana

          #/> Tools <\#
          vscode-with-extensions
          exa
          ripgrep
          evcxr
          gnome.seahorse
          gnome.gnome-keyring
          gnome.libgnome-keyring
        ];
        shellHook = ''
          xoxo() {
            [ -d "$1" ] && {
              PATH="$1:$PATH"
              find "$1" -type f ! -executable -exec chmod +x {} \;
            }
          }

          rsBIN() {
            type rust-sctipt >/dev/null 2>&1 &&
            [ -d bin ] && rust-script bin/autostart
          }
          #/> Autorun <\#
          export NIXPKGS_ALLOW_UNFREE=1
          type rust-sctipt >/dev/null 2>&1 &&
            [ -d bin ] && rust-script bin/autostart
          # xoxo bin
          # versions
          # pSQLer --start
          # printf "\n"
          # CrunQ
          # ide .
          cargo run --quiet
        '';
      };
    });
}
