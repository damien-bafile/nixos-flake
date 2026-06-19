{ pkgs, inputs, ... }:
{
  # System packages: Emacs itself + build tools for straight.el + language servers
  environment.systemPackages = [
    (if pkgs.stdenv.isLinux then pkgs.emacs-pgtk else pkgs.emacs)
    pkgs.gcc
    pkgs.gnumake
    pkgs.cmake
    pkgs.pkg-config
    pkgs.autoconf
    pkgs.automake
    pkgs.libtool
    pkgs.gnutls
    pkgs.texinfo
    pkgs.emacs-all-the-icons-fonts
    pkgs.source-code-pro
    pkgs.ripgrep
    pkgs.fd
    pkgs.git
    pkgs.aspell
    pkgs.shellcheck
    pkgs.clang-tools              # clangd
    pkgs.nodePackages.pyright
    pkgs.nodePackages.bash-language-server
    pkgs.nil                      # Nix LSP
    pkgs.marksman                 # Markdown LSP
  ];

  # User configuration – your exact emacs-config repo
  home-manager.sharedModules = [{
    home.file.".emacs.d".source = inputs.emacs-config;
  }];
}
