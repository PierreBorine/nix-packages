#!/usr/bin/env bash

QS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR_="$HOME/Pictures/Wallpapers"
THUMB_DIR="$HOME/.cache/wallpaper_picker/thumbs"

SRC_DIR="$(readlink -f "$SRC_DIR_")"

handle_wallpaper_prep() {
    mkdir -p "$THUMB_DIR"
    (
        for thumb in "$THUMB_DIR"/*; do
            [ -e "$thumb" ] || continue
            filename=$(basename "$thumb")
            if [ ! -f "$SRC_DIR/$filename" ]; then
                rm -f "$thumb"
            fi
        done

        for img in "$SRC_DIR"/*.{jpg,jpeg,png,webp,gif}; do
            [ -e "$img" ] || continue

            thumb="$THUMB_DIR/$(basename "$img")"
            if [ ! -f "$thumb" ]; then
                ffmpegthumbnailer -i "$img" -o "$thumb" -s 640 -q 7
            fi
        done
    ) &

    TARGET_INDEX=0
    CURRENT_SRC=""

    if [ -z "$CURRENT_SRC" ] && command -v awww >/dev/null; then
        CURRENT_SRC=$(awww query 2>/dev/null | grep -o "$SRC_DIR/[^ ]*" | head -n1)
        CURRENT_SRC=$(basename "$CURRENT_SRC")
    fi

    if [ -n "$CURRENT_SRC" ]; then
        MATCH_LINE=$(ls -1 "$THUMB_DIR" | grep -nF "$CURRENT_SRC" | cut -d: -f1)
        if [ -n "$MATCH_LINE" ]; then
            TARGET_INDEX=$((MATCH_LINE - 1))
        fi
    fi
    echo "$TARGET_INDEX" > "/tmp/wallpaper_picker_target"
}

handle_wallpaper_prep
quickshell -p "$QS_DIR/shell.qml"
