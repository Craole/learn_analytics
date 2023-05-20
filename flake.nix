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
          #/> Bin <\#
          Ccheck() { cargo check -- "$@" ;}
          Crun() { cargo run -- "$@" ;}
          CrunQ() { cargo run --quiet -- "$@" ;}
          CrunR() { cargo run --release --quiet -- "$@" ;}
          Cwatch() {
            cargo watch \
              --quiet \
              --clear \
              --exec \
              "run --quiet -- $*"
          }
          CMDer() {
            if type "$1" >/dev/null 2>&1; then
              eval "$*"
            # else
            #   printf "Command not found: %s" "$1"
            #   exit 1
            fi
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
          versions() {
            # rustc -vV
            rustc --version
            cargo --version
            rust-script --version
            psql --version
            sqlx --version
          }
          pSQLer() { rust-script bin/psqler "$@" ;}
          # rust-script bin/psqler --start
          # rust-script bin/psqler

          #/> Autorun <\#
          CMDer Editor .
          versions
          printf "\n"
          pSQLer --start
          printf "\n"
          # CrunR
        '';
      };
    });
}
