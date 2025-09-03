#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LINKS_FILE="$SCRIPT_DIR/Links.txt"

if [[ ! -f "$LINKS_FILE" ]]; then
    yad --error --text="Links.txt not found in script directory" --on-top
    exit 1
fi

mapfile -t urls < "$LINKS_FILE"
total=${#urls[@]}

for ((i=0; i<total; i++)); do
    url="${urls[i]}"
    [[ -z "$url" ]] && continue
    
    xdg-open "$url" >/dev/null 2>&1
    
    if ((i < total-1)); then
        new_url=$(yad --entry --text="Update URL (optional):" --entry-text="" --button="Next:0" --title="URL Opener" --width=235 --height=103 --on-top --geometry=235x103+1655+61 --fixed --no-escape 2>/dev/null)
        [[ $? -ne 0 ]] && exit 0
        if [[ -n "$new_url" ]]; then
            urls[i]="$new_url"
            printf '%s\n' "${urls[@]}" > "$LINKS_FILE"
        fi
    else
        new_url=$(yad --entry --text="Update URL (optional):" --entry-text="" --button="Finish:0" --title="URL Opener" --width=235 --height=103 --on-top --geometry=235x103+1655+61 --fixed --no-escape 2>/dev/null)
        [[ $? -ne 0 ]] && exit 0
        if [[ -n "$new_url" ]]; then
            urls[i]="$new_url"
            printf '%s\n' "${urls[@]}" > "$LINKS_FILE"
        fi
    fi
done
