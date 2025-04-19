{ config, pkgs, ... }: {
  home.username = "thierry";
  home.homeDirectory = "/home/thierry";

  home.packages = with pkgs; [
    neofetch
    firefox
    waybar
    rofi-wayland
    kitty
    wl-clipboard
  ];

  programs.git = {
    enable = true;
    userName = "Thierry Staakman";
    userEmail = "thierry@example.com";
  };

  home.file.".config/waybar/config".source = ./waybar-config.json;
  home.file.".config/waybar/style.css".source = ./waybar-style.css;

  home.stateVersion = "24.11";
}
