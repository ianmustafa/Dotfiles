#!/bin/sh

niri msg --json event-stream | jq --unbuffered -c '
  select(.WindowOpenedOrChanged != null) | .WindowOpenedOrChanged.window
' | while read -r window; do

  id=$(echo "$window" | jq -r '.id')
  app_id=$(echo "$window" | jq -r '.app_id')
  title=$(echo "$window" | jq -r '.title')
  is_floating=$(echo "$window" | jq -r '.is_floating')

  if [ "$app_id" = "zen" ] && [ "$is_floating" = "false" ]; then
    # Use a case statement with wildcards instead of regex
    case "$title" in
    *Login*Google* | *"PayPal Checkout"*)
      niri msg action focus-window --id "$id"
      niri msg action toggle-window-floating
      niri msg action set-column-width 640
      niri msg action set-window-height 640
      ;;
    esac
  fi
done
