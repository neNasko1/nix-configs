set shell := ["bash", "-uc"]

rebuild-zenbook:
    echo "Rebuilding nixos and home-manager configurations"
    bash nixos-rebuild switch --flake /home/atanasd/my-nix#default --show-trace
