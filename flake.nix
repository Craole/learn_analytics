{
  description = "Data Analytics Portfolio Flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
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

          #/> SQL <\#
          postgresql_15
          sqlx-cli

          #/> Tools <\#
          exa
          ripgrep
          jupyter
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
