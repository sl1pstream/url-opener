#!/bin/bash

# Force X11 backend for yad to respect --on-top on Wayland
export GDK_BACKEND=x11

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LINKS_FILE="$SCRIPT_DIR/Links.txt"
TIMESTAMP_FILE="$SCRIPT_DIR/.last_run"

if [[ ! -f "$LINKS_FILE" ]]; then
    yad --error --text="Links.txt not found in script directory" --on-top
    exit 1
fi

START_TIME=$(date +"%m/%d/%Y %I:%M %p")
last_run=""
[[ -f "$TIMESTAMP_FILE" ]] && last_run=$(cat "$TIMESTAMP_FILE")

mapfile -t urls < "$LINKS_FILE"
total=${#urls[@]}

for ((i=0; i<total; i++)); do
    url="${urls[i]}"
    [[ -z "$url" ]] && continue
    
    brave --incognito "$url" >/dev/null 2>&1 &
    
    dialog_text="Update URL (optional):"
    [[ -n "$last_run" ]] && dialog_text="Last completed: $last_run\n$dialog_text"
    
    if ((i < total-1)); then
        new_url=$(yad --entry --text="$dialog_text" --entry-text="" --button="Next:0" --title="URL Opener" --width=235 --height=103 --on-top --geometry=235x103+1655+61 --fixed --no-escape 2>/dev/null)
        [[ $? -ne 0 ]] && exit 0
        if [[ -n "$new_url" ]]; then
            urls[i]="$new_url"
            printf '%s\n' "${urls[@]}" > "$LINKS_FILE"
        fi
    else
        new_url=$(yad --entry --text="$dialog_text" --entry-text="" --button="Finish:0" --title="URL Opener" --width=235 --height=103 --on-top --geometry=235x103+1655+61 --fixed --no-escape 2>/dev/null)
        [[ $? -ne 0 ]] && exit 0
        if [[ -n "$new_url" ]]; then
            urls[i]="$new_url"
            printf '%s\n' "${urls[@]}" > "$LINKS_FILE"
        fi
        echo "$START_TIME" > "$TIMESTAMP_FILE"
    fi
done
