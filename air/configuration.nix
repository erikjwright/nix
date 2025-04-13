{
  pkgs,
  ...
}:
{
  # users.defaultUserShell=pkgs.zsh;

  users.users.erik = {
    # isNormalUser  = true;
    home = "/Users/erik";
    description = "Erik Wright";
    # extraGroups  = [ "wheel" "networkmanager" ];
    # openssh.authorizedKeys.keys  = [ "ssh-dss AAAAB3Nza... alice@foobar" ];
    shell = pkgs.zsh;
  };

  # system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;

  # environment.variables = {
  #   # see https://github.com/ghostty-org/ghostty/discussions/2832
  #   XDG_DATA_DIRS = [ "/Applications/Ghostty.app/Contents/Resources/ghostty/shell-integration" ];
  # };

  environment.systemPackages = with pkgs; [
    curl
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  fonts.packages = with pkgs; [
    nerd-fonts.monaspace
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";
    taps = [
    ];
    brews = [
      "zsh-vi-mode"
      "zsh-autosuggestions"
    ];
    casks = [
      "1password"
      "1password-cli"
      "beekeeper-studio"
      "bitwarden"
      "chromium"
      "docker"
      "ghostty"
      "keybase"
      "mullvadvpn"
      "notion"
      "ollama"
      "podman-desktop"
      "raycast"
      "yubico-authenticator"
      "zen-browser"
    ];
    masApps = {
      slack = 803453959;
    };
  };

  # services.udev.packages = [ pkgs.yubikey-personalization ];
  #
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}
