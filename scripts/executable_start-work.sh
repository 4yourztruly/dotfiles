#!/bin/bash

# --- Firefox ---
firefox "https://app.clickup.com/31528086/my-work" \
        "https://studio.apollographql.com/sandbox/explorer" \
        "http://localhost:3000/" &
sleep 2
hyprctl dispatch movetoworkspace 1

# --- Cursor apps ---
# Cursor 1
(cd /home/utopiajack/repos/sinom-web && ./cursor-app-1) &
sleep 1
hyprctl dispatch movetoworkspace 2

# Cursor 2
(cd /home/utopiajack/repos/sinom-api && ./cursor-app-2) &
sleep 1
hyprctl dispatch movetoworkspace 3

# --- Terminals (Kitty with Fish) ---
kitty --directory=/home/utopiajack/repos/sinom-web &
kitty --directory=/home/utopiajack/repos/sinom-api/db &
kitty --directory=/home/utopiajack/repos/sinom-api &
kitty --directory=/home/utopiajack/repos/sinom-api &
sleep 2
hyprctl dispatch movetoworkspace 4

# --- Discord ---
discord &
sleep 1
hyprctl dispatch movetoworkspace 5
