FROM ubuntu
RUN apt-get update && apt-get install -y curl wget jq unzip screen
EXPOSE 19132/udp
VOLUME /data/server
WORKDIR /data
COPY --chmod=700 run.sh .
ENV LD_LIBRARY_PATH=.

# server.properties settings
ENV level_seed=

CMD ["./run.sh"]
