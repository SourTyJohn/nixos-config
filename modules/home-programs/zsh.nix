{
  config,
  pkgs,
  ...
}:
{
  config.home.packages = with pkgs; [ zsh ];

  config.programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    history.size = 10000;

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
  };
  # Ctrl+Left Arrow (move backward a word)
  # bindkey "^[[1;5D" backward-word

  # Ctrl+Right Arrow (move forward a word)
  # bindkey "^[[1;5C" forward-word
}
