#!/bin/bash

main() {
  echo "Updater started."

  sleep 1m

  while true; do

    echo -n "Checking for update... "

    # Get current version
    [ -f "server/version" ] && current_version=$(cat "server/version") || current_version=0

    # Get latest version
    url="https://net.web.minecraft-services.net/api/v1.0/download/links"
    download_url=$(curl -s "$url" | jq -r ".result.links[] | select(.downloadType==\"serverBedrockLinux\") | .downloadUrl")
    latest_version=$(echo "$download_url" | sed 's#.*r-##; s#\.zip##')

    # Stop if not up-to-date
    [ $current_version != $latest_version ] && stop_server || echo "No update."

    sleep 1h

  done
}

stop_server() {
  echo "New update available!"
  echo "Stopping server for update..."
  screen -S mc -X stuff "tellraw @a {\"rawtext\":[{\"text\":\"§cRestarting in 30 seconds...\"}]}\n"
  sleep 20
  screen -S mc -X stuff "tellraw @a {\"rawtext\":[{\"text\":\"§cRestarting in 10 seconds...\"}]}\n"
  sleep 5
  screen -S mc -X stuff "tellraw @a {\"rawtext\":[{\"text\":\"§cRestarting in 5 seconds...\"}]}\n"
  sleep 5
  screen -S mc -X stuff "stop\n"
}

main
