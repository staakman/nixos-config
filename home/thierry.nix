{ config, pkgs, ... }: {
  
  home.username = "thierry";
  home.homeDirectory = "/home/thierry";

  home.packages = with pkgs; [
    neofetch          # system info
    firefox		        # browser
    waybar		        # top bar
    rofi-wayland      # ?
    kitty             # terminal
    wl-clipboard      # copy pasta 
    gcc               # c compiler
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
