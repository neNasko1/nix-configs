set shell := ["bash", "-uc"]

update-flake:
    echo "Updating flake"
    nix flake update

rebuild-zenbook:
    echo "Rebuilding nixos and home-manager configurations"
    sudo nixos-rebuild switch --flake .#default --show-trace

check:
    echo "Evaluating the flake"
    nix flake check --show-trace

switch-work:
    echo "Activating the work-box home configuration"
    nix run .#home-manager -- switch --flake .#adimitrov -b backup
