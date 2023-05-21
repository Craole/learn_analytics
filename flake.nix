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
          #/> Authentication <\#
          # # see https://unix.stackexchange.com/a/295652/332452
          # #source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
          # systemctl --user import-environment DISPLAY XAUTHORITY
          # if command -v dbus-update-activation-environment >/dev/null 2>&1; then
          #     dbus-update-activation-environment DISPLAY XAUTHORITY
          # fi

          # # see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
          # eval $(gnome-keyring-daemon --start)
          # export SSH_AUTH_SOCK

          # # see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
          # mkdir -p "$HOME"/.local/share/keyrings

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
          edit() { CMDer Editor "$@";}
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
          pSQLer() { rust-script bin/pSQLer "$@" ;}
          IDE() {
            seahorse &
            code .
            jupyter notebook --no-browser
          }
          # rust-script bin/psqler --start
          # rust-script bin/psqler

          #/> Autorun <\#
          # IDE
          versions
          printf "\n"
          pSQLer --start
          printf "\n"
          CrunR
        '';
      };
    });
}
