gen-icons PATH:
    for i in 16 24 48 64 96 128; do mkdir -p ./icons/''${i}x''${i}/apps && nix-shell -p imagemagick --run "magick {{PATH}} -background none -resize ''${i}x''${i} ./icons/''${i}x''${i}/apps/''$(basename {{PATH}})"; done
