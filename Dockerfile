FROM ubuntu:20.04
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl unzip
WORKDIR /root
COPY ./run.sh ./
VOLUME /minecraft

# server.properties settings
ENV server_name="Dedicated Server"
ENV gamemode=survival
ENV force_gamemode=FALSE
ENV difficulty=easy
ENV allow_cheats=FALSE
ENV max_players=10
ENV online_mode=TRUE
ENV allow_list=FALSE
ENV server_port=19132
ENV server_portv6=19133
ENV view_distance=32
ENV tick_distance=4
ENV player_idle_timeout=30
ENV max_threads=8
ENV level_name="Bedrock level"
ENV level_seed=
ENV default_player_permission_level=member
ENV texturepack_required=FALSE
ENV content_log_file_enabled=FALSE
ENV compression_threshold=1
ENV server_authoritative_movement=server-auth
ENV player_movement_score_threshold=20
ENV player_movement_action_direction_threshold=0.85
ENV player_movement_distance_threshold=0.3
ENV player_movement_duration_threshold_in_ms=500
ENV correct_player_movement=FALSE
ENV server_authoritative_block_breaking=FALSE

CMD /bin/bash run.sh
