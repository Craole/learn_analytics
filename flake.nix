{
  description = "Rust Nightly Development Environment";
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

      pythonPackages = pkgs.python311.withPackages (ps: [
        ps.black
        ps.pandas
        ps.matplotlib
        ps.seaborn
      ]);
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

          #/> Python <\#
          pythonPackages

          #/> PostgreSQL <\#
          postgresql

          #/> Tools <\#
          exa
          fd
          ripgrep
        ];

        shellHook = ''
          #/> Aliases <\#
          alias ls='exa \
            --icons \
            --color-scale \
            --header \
            --no-user \
            --git \
            --group-directories-first \
            --all \
            --long \
            --sort=.name
          '
          alias cI='cargo install'
          alias cR='cargo run --quiet'
          alias cW='cargo watch \
            --quiet \
            --clear \
            --exec \
            "run --quiet --"
          '

          #/> Autostart <\#
          [ -f Cargo.toml ] || cargo init
          rustc -vV
          python --version
          psql --version
        '';
      };
    });
}