# My NixOS Config


## Installation

- Copy repo to /etc/nixos
- Replace hosts/default/hardware-configuration.nix with auto-generated /etc/nixos/hardware-configuration.nix

- Install nixos config:
`sudo nixos-rebuild switch --flake /etc/nixos#default`

- Install home-manager config:
`nix-shell -p home-manager`

`home-manager switch --flake /etc/nixos#default`

`exit`


# Thanks!

Config was made with parts from other configs:
- https://github.com/sund3RRR/sunderOS
- 


# Version 5-stable

- Firefox + Librewolf
- Vscode
- Programming: docker, python, pgadmin, redis, putty, git
- Steam
- zapret-discord-youtube
