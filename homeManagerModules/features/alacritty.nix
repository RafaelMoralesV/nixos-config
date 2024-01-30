{ ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";

      window.opacity = 0.8;

      font = {
        size = 12.0;

        normal.family = "Agave Nerd Font";
        bold.family = "Agave Nerd Font";
        italic.family = "Agave Nerd Font";
      };

      cursor.style = {
        shape = "Beam";
        blinking = "Always";
      };

      keyboard.bindings = [
        { key = "Return"; mods = "Control|Shift"; action = "CreateNewWindow"; }
      ];
    };
  };
}

