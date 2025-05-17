{
  pkgs,
  wallpaper,
  ...
}: let
in {
  home-manager.sharedModules = [
    ({config, ...}: {

      catppuccin.enable = true;
      catppuccin.flavor = "mocha";

      catppuccin.kitty.enable = true;
      
      catppuccin.starship.enable = true;
      catppuccin.starship.flavor = "mocha";
      
      catppuccin.hyprland.enable = true;
      catppuccin.hyprland.flavor = "mocha";
      catppuccin.hyprland.accent = "peach";

      catppuccin.wlogout.enable = false;

      #catppuccin.cursors.enable = true;
      #catppuccin.cursors.accent = "mauve";

      # Set wallpaper
      services.hyprpaper = {
        enable = true;
        settings = {
          preload = ["${../wallpapers/${wallpaper}}"];
          wallpaper = [",${../wallpapers/${wallpaper}}"];
        };
      };
      
      home.pointerCursor = {
        name = "Bibata-Modern-Ice";
        package = pkgs.bibata-cursors;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
    })
  ];
}
