{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # nix.settings.trusted-users = [ "erik" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_13;

  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  networking.hostName = "nixos";
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;
  # networking.networkmanager.enable = false;

  nixpkgs.config.allowUnfree = true;

  hardware.bluetooth.package = pkgs.bluez;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Name = "nixos";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {
        AutoEnable = "true";
      };
      LE = {
        EnableAdvMonInterleaveScan = "true";
      };
    };
  };

  fonts.packages = with pkgs; [
    # nerd-fonts.fira-code
    # nerd-fonts.meslo-lg
    nerd-fonts.monaspace
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
  ];

  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1";

    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  # environment.shells = with pkgs; [ zsh ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    age
    cryptsetup
    curl
    dig
    gparted
    # gnupg
    openssl
    pinentry
    pinentry-tty
  ];

  users.defaultUserShell = pkgs.zsh;

  users = {
    users.erik = {
      shell = pkgs.zsh;
      isNormalUser = true;
      description = "Erik Wright";
      extraGroups = [
        "networkmanager"
        # "video"
        "wheel"
      ];
    };
  };

  programs._1password = {
    enable = true;
  };
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "erik" ];
  };
  programs.git.enable = true;
  programs.hyprland.enable = true;
  # programs.hyprland = {
  #     enable = true;
  #     withUWSM = true; # recommended for most users
  #     xwayland.enable = true; # Xwayland can be disabled.
  # };

  programs.light.enable = true;
  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  #
  # programs.gpg-agent = {
  #     enable = true;
  #     defaultCacheTtl = 1800;
  #     enableSshSupport = true;
  # };

  # List services that you want to enable:
  # security.rtkit.enable = true;
  #
  # services.pipewire = {
  #     enable = true;
  #     alsa.enable = true;
  #     alsa.support32Bit = true;
  #     pulse.enable = true;
  #     # If you want to use JACK applications, uncomment this
  #     #jack.enable = true;
  # };
  #
  # services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
  #     "monitor.bluez.properties" = {
  #         "bluez5.enable-sbc-xq" = true;
  #         "bluez5.enable-msbc" = true;
  #         "bluez5.enable-hw-volume" = true;
  #         "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
  #     };
  # };

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.keybase.enable = true;
  services.kbfs.enable = true;

  services.keyd = {
    enable = true;
    keyboards = {
      defaults = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
