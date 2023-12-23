FROM ubuntu
RUN apt-get update && apt-get install -y curl wget unzip
EXPOSE 19132/udp
VOLUME /data/server
WORKDIR /data
COPY --chmod=700 run.sh .

# server.properties settings
ENV server_name="Dedicated Server"
ENV gamemode=survival
ENV force_gamemode=false
ENV difficulty=easy
ENV allow_cheats=false
ENV max_players=10
ENV online_mode=true
ENV allow_list=false
ENV server_port=19132
ENV server_portv6=19133
ENV enable_lan_visibility=true
ENV view_distance=32
ENV tick_distance=4
ENV player_idle_timeout=30
ENV max_threads=8
ENV level_name="Bedrock level"
ENV level_seed=
ENV default_player_permission_level=member
ENV texturepack_required=false
ENV content_log_file_enabled=false
ENV compression_threshold=1
ENV compression_algorithm=zlib
ENV server_authoritative_movement=server-auth
ENV player_movement_score_threshold=20
ENV player_movement_action_direction_threshold=0.85
ENV player_movement_distance_threshold=0.3
ENV player_movement_duration_threshold_in_ms=500
ENV correct_player_movement=false
ENV server_authoritative_block_breaking=false
ENV chat_restriction=None
ENV disable_player_interaction=false
ENV client_side_chunk_generation_enabled=true
ENV block_network_ids_are_hashes=true
ENV disable_persona=false
ENV disable_custom_skins=false
ENV server_build_radius_ratio=Disabled
ENV allow_outbound_script_debugging=false
ENV allow_inbound_script_debugging=false
ENV script_debugger_auto_attach=disabled

CMD ./run.sh
