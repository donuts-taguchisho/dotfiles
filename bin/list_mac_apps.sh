#!/bin/bash

SEARCH_PATHS=("/Applications" "$HOME/Applications")

TEMP_FILE=$(mktemp)

for BASE_PATH in "${SEARCH_PATHS[@]}"; do
    if [ -d "$BASE_PATH" ]; then
        find "$BASE_PATH" -maxdepth 1 -type d -iname "*.app" -exec basename {} \; | sed 's/\.app//g' >> "$TEMP_FILE"
        find "$BASE_PATH" -maxdepth 1 -type l -iname "*.app" -print0 | while IFS= read -r -d $'\0' LINK_PATH; do
            APP_NAME=$(basename "$LINK_PATH")
            echo "$APP_NAME" | sed 's/\.app//g' >> "$TEMP_FILE"
        done
    fi
done

if [ -s "$TEMP_FILE" ]; then
    cat "$TEMP_FILE" | sort | uniq
else
    echo "アプリケーションは見つかりませんでした。"
fi

rm "$TEMP_FILE"
