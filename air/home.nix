{ pkgs, neovim-nightly-overlay, ... }:
{
  home.username = "erik";
  home.homeDirectory = "/Users/erik";

  home.stateVersion = "24.11";

  # home.sessionVariables = {
  #   XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
  # };
  # xdg.enable = true;

  # services.ollama = {
    # enable = true;
    # Optional: load models on startup
    # loadModels = [];
  # };

  home.packages = with pkgs; [
    bruno
    bruno-cli
    chezmoi
    # code-cursor
    # dbeaver-bin
    direnv
    eza
    fzf
    git
    # ghostty
    gnupg
    lazygit
    neovim-nightly-overlay.packages.${system}.default
    nixfmt-rfc-style
    openssh
    podman
    podman-compose
    podman-tui
    rclone
    ripgrep
    sops
    starship
    thunderbird-latest-unwrapped
    yazi
    # yubioath-flutter
    zoxide
  ];

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
  # programs.htop.enable = true;
  # programs.htop.settings.show_program_path = true;
}
