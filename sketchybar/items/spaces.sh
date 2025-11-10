#!/bin/bash

SPACE_COUNT=$(yabai -m query --spaces | jq 'length')

for sid in $(seq 1 $SPACE_COUNT); do
  sketchybar --add space space.$sid left \
    --set space.$sid space=$sid \
    icon=$sid \
    label.font="sketchybar-app-font:Regular:16.0" \
    label.padding_right=16 \
    label.y_offset=-1 \
    background.color=$ITEM_BG_COLOR \
    script="$PLUGIN_DIR/space.sh"
done

sketchybar --add item space_separator left \
  --set space_separator icon="􀆊" \
  icon.color=$ACCENT_COLOR \
  icon.padding_left=4 \
  label.drawing=off \
  background.drawing=off \
  script="$PLUGIN_DIR/space_windows.sh" \
  --subscribe space_separator space_windows_change
