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
        ];
        shellHook = ''
          # envup() { [ -f "$workspace/.env" ] && . "$workspace/.env" ;}
          # export workspace="./."
          # source $workspace/bin/init_env
          # cargo check

          Crun() { cargo run -- "$@" ;}
          CrunQ() { cargo run --quiet -- "$@" ;}
          Cwatch() {
            cargo watch \
              --quiet \
              --clear \
              --exec \
              "run --quiet -- $*"
          }
          lsl() {
            exa \
              --icons \
              --all \
              --long \
              --color-scale \
              --no-user \
              --git \
              --group-directories-first \
              --sort=.name \
              --time 'modified' \
              --header \
              "$@"
          }
          verions() {
            # rustc -vV
            rustc --version
            cargo --version
            psql --version
          }
        '';
      };
    });
}
