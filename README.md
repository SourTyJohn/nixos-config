# My NixOS Config


## Installation

- Copy repo to ~/Documents/nix-config/nixos
- Replace hosts/default/hardware-configuration.nix with auto-generated /etc/nixos/hardware-configuration.nix

- Install nixos config:
`sudo nixos-rebuild switch --flake ~/Documents/nix-config/nixos#default`

- Install home-manager config:
`nix-shell -p home-manager`

`home-manager switch --flake ~/Documents/nix-config/nixos#default`

`exit`


# Thanks!

Config was made with parts from other configs:
- https://github.com/sund3RRR/sunderOS
- https://github.com/AlexNabokikh/nix-config


# Version 16-stable

- Firefox + Librewolf
- Vscode
- Programming: docker, python, pgadmin4, redis, putty, git
- Steam + proton (Intel CPU / Nvidia GPU)
- Discord
- zapret-discord-youtube
- Trillium
- cursor AI app


# zsh aliases

`python-shell` : starts python dev shell
 