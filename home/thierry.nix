{ config, pkgs, ... }: {
  
  home.username = "thierry";
  home.homeDirectory = "/home/thierry";

  home.packages = with pkgs; [
    neofetch          # system info
    waybar		        # top bar
    kitty             # terminal
    wl-clipboard      # copy pasta 
    gcc               # c compiler
    home-manager
  ];

  programs.git = {
    enable = true;
    userName = "Thierry Staakman";
    userEmail = "thierry@example.com";
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.home-manager.enable = true;


  # home.file.".config/waybar/config".source = ./../modules/waybar/waybar-config.json;
  # home.file.".config/waybar/style.css".source = ./../modules/waybar/waybar-style.css;

  home.stateVersion = "24.11";
}
