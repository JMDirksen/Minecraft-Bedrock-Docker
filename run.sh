#!/bin/bash

cd /minecraft

echo "server-name=${server_name}" > server.properties
echo "gamemode=${gamemode}" >> server.properties
echo "force-gamemode=${force_gamemode}" >> server.properties
echo "difficulty=${difficulty}" >> server.properties
echo "allow-cheats=${allow_cheats}" >> server.properties
echo "max-players=${max_players}" >> server.properties
echo "online-mode=${online_mode}" >> server.properties
echo "allow-list=${allow_list}" >> server.properties
echo "server-port=${server_port}" >> server.properties
echo "server-portv6=${server_portv6}" >> server.properties
echo "view-distance=${view_distance}" >> server.properties
echo "tick-distance=${tick_distance}" >> server.properties
echo "player-idle-timeout=${player_idle_timeout}" >> server.properties
echo "max-threads=${max_threads}" >> server.properties
echo "level-name=${level_name}" >> server.properties
echo "level-seed=${level_seed}" >> server.properties
echo "default-player-permission-level=${default_player_permission_level}" >> server.properties
echo "texturepack-required=${texturepack_required}" >> server.properties
echo "content-log-file-enabled=${content_log_file_enabled}" >> server.properties
echo "compression-threshold=${compression_threshold}" >> server.properties
echo "server-authoritative-movement=${server_authoritative_movement}" >> server.properties
echo "player-movement-score-threshold=${player_movement_score_threshold}" >> server.properties
echo "player-movement-action-direction-threshold=${player_movement_action_direction_threshold}" >> server.properties
echo "player-movement-distance-threshold=${player_movement_distance_threshold}" >> server.properties
echo "player-movement-duration-threshold-in-ms=${player_movement_duration_threshold_in_ms}" >> server.properties
echo "correct-player-movement=${correct_player_movement}" >> server.properties
echo "server-authoritative-block-breaking=${server_authoritative_block_breaking}" >> server.properties

while true
do

  # Get current version
  [ -f "version.txt" ] && current_version=$(cat "version.txt") || current_version=0
  echo "Current version: $current_version"

  # Get latest version
  curl -s -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36" -o "download-page.html" "https://www.minecraft.net/en-us/download/server/bedrock"
  download_url=$(grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' download-page.html)
  rm download-page.html
  latest_version=$(echo "$download_url" | sed 's#.*r-##; s#\.zip##')
  echo "Latest version: $latest_version"

  # Download new version
  [ $current_version != $latest_version ] && {
    echo "Downloading new version..."
    curl -s -o bedrock.zip "$download_url"
    unzip -oq bedrock.zip -x server.properties permissions.json
    echo "$latest_version" > "version.txt"
    echo "Updated!"
  }

  # Starting server
  echo "Starting server..."
  LD_LIBRARY_PATH=. ./bedrock_server
  echo "Restarting in 3 seconds..."
  sleep 3

done
