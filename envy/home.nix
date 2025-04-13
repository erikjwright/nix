{
  pkgs,
  neovim-nightly-overlay,
  nixpkgs-stable,
  zen-browser,
  ...
}:
{
  home.username = "erik";
  home.homeDirectory = "/home/erik";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    beekeeper-studio
    biome
    # bitwarden-cli
    bitwarden-desktop
    # cameractrls
    chezmoi
    clang
    cloudflared
    cryptomator
    czkawka
    dbeaver-bin
    diceware
    direnv
    dive
    eza
    fd
    ffmpeg
    fzf
    ghostty
    hyprpolkitagent
    imagemagick
    jq
    keybase-gui
    lazygit
    lazysql
    loupe
    mullvad-browser
    neovim-nightly-overlay.packages.${system}.default
    obs-studio
    overskride
    pinentry-tty
    podman
    podman-compose
    podman-tui
    poppler
    rclone
    ripgrep
    sops
    starship
    swaynotificationcenter
    thunderbird
    tutanota-desktop
    ungoogled-chromium
    unzip
    vaultwarden
    vmware-workstation
    waybar
    wofi
    yazi
    yq
    zen-browser.packages."${system}".default
    zoxide
  ];

  #   wayland.windowManager.hyprland = {
  # enable = true;
  # # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
  # package = null;
  # portalPackage = null;
  # };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.htop.enable = true;
  programs.gpg.enable = true;

  # programs.zsh.enable = true;

  # programs.firefox.enable = true;

}
