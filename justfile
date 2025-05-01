set shell := ["bash", "-uc"]

update-flake:
    echo "Updating flake"
    nix flake update

rebuild-zenbook:
    echo "Rebuilding nixos and home-manager configurations"
    bash nixos-rebuild switch --flake .#default --show-trace --upgrade
