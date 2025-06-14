{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      themes = {
        catppuccin-mocha = {
          bg = "#1e1e2e";
          fg = "#cdd6f4";
          red = "#f38ba8";
          green = "#a6e3a1";
          blue = "#89b4fa";
          yellow = "#f9e2af";
          magenta = "#f5c2e7";
          orange = "#fab387";
          cyan = "#94e2d5";
          black = "#181825";
          white = "#cdd6f4";
        };
      };
    };
  };
}