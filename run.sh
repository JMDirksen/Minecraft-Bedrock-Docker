#!/bin/bash

main () {
  echo "server-name=${server_name}" > server/server.properties
  echo "gamemode=${gamemode}" >> server/server.properties
  echo "force-gamemode=${force_gamemode}" >> server/server.properties
  echo "difficulty=${difficulty}" >> server/server.properties
  echo "allow-cheats=${allow_cheats}" >> server/server.properties
  echo "max-players=${max_players}" >> server/server.properties
  echo "online-mode=${online_mode}" >> server/server.properties
  echo "allow-list=${allow_list}" >> server/server.properties
  echo "server-port=${server_port}" >> server/server.properties
  echo "server-portv6=${server_portv6}" >> server/server.properties
  echo "enable-lan-visibility=${enable_lan_visibility}" >> server/server.properties
  echo "view-distance=${view_distance}" >> server/server.properties
  echo "tick-distance=${tick_distance}" >> server/server.properties
  echo "player-idle-timeout=${player_idle_timeout}" >> server/server.properties
  echo "max-threads=${max_threads}" >> server/server.properties
  echo "level-name=${level_name}" >> server/server.properties
  echo "level-seed=${level_seed}" >> server/server.properties
  echo "default-player-permission-level=${default_player_permission_level}" >> server/server.properties
  echo "texturepack-required=${texturepack_required}" >> server/server.properties
  echo "content-log-file-enabled=${content_log_file_enabled}" >> server/server.properties
  echo "compression-threshold=${compression_threshold}" >> server/server.properties
  echo "server-authoritative-movement=${server_authoritative_movement}" >> server/server.properties
  echo "player-movement-score-threshold=${player_movement_score_threshold}" >> server/server.properties
  echo "player-movement-action-direction-threshold=${player_movement_action_direction_threshold}" >> server/server.properties
  echo "player-movement-distance-threshold=${player_movement_distance_threshold}" >> server/server.properties
  echo "player-movement-duration-threshold-in-ms=${player_movement_duration_threshold_in_ms}" >> server/server.properties
  echo "correct-player-movement=${correct_player_movement}" >> server/server.properties
  echo "server-authoritative-block-breaking=${server_authoritative_block_breaking}" >> server/server.properties
  echo "chat-restriction=${chat_restriction}" >> server/server.properties
  echo "disable-player-interaction=${disable_player_interaction}" >> server/server.properties
  echo "client-side-chunk-generation-enabled=${client_side_chunk_generation_enabled}" >> server/server.properties
  echo "block-network-ids-are-hashes=${block_network_ids_are_hashes}" >> server/server.properties
  echo "disable-persona=${disable_persona}" >> server/server.properties
  echo "disable-custom-skins=${disable_custom_skins}" >> server/server.properties
  echo "server-build-radius-ratio=${server_build_radius_ratio}" >> server/server.properties
  echo "allow-outbound-script-debugging=${allow_outbound_script_debugging}" >> server/server.properties
  echo "allow-inbound-script-debugging=${allow_inbound_script_debugging}" >> server/server.properties
  echo "script-debugger-auto-attach=${script_debugger_auto_attach}" >> server/server.properties

  # Get current version
  [ -f "version" ] && current_version=$(cat "version") || current_version=0
  echo "Current version: $current_version"

  # Get latest version
  agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.54 Safari/537.36"
  curl -s -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "$agent" -o "download-page.html" "https://www.minecraft.net/en-us/download/server/bedrock"
  download_url=$(grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' "download-page.html")
  rm "download-page.html"
  latest_version=$(echo "$download_url" | sed 's#.*r-##; s#\.zip##')
  echo "Latest version: $latest_version"

  # Update if not up-to-date
  [ $current_version != $latest_version ] && update

  # Starting server
  echo "Starting server..."
  cd server
  LD_LIBRARY_PATH=. ./bedrock_server
}

update () {
  # Download new version
  echo "Downloading new version..."
  download_file=$(echo "$download_url" | sed 's#.*/##')
  wget -q "$download_url" -O "$download_file"

  # Backup current config
  [ -f "server/server.properties" ] && cp "server/server.properties" "server/server.properties.bak"
  [ -f "server/permissions.json" ] && cp "server/permissions.json" "server/permissions.json.bak"

  # Extract
  echo "Extracting archive..."
  unzip -oq "$download_file" -d "server"
  rm "$download_file"
  echo "$latest_version" > "version"
  echo "Updated!"

  # Restore config
  cp "server/server.properties" "server/server.properties.org"
  cp "server/permissions.json" "server/permissions.json.org"
  [ -f "server/server.properties.bak" ] && mv "server/server.properties.bak" "server/server.properties"
  [ -f "server/permissions.json.bak" ] && mv "server/permissions.json.bak" "server/permissions.json"
}

main
