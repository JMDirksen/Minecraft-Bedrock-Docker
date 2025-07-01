# Deploy

```
git clone https://github.com/JMDirksen/Minecraft-Bedrock-Docker.git minecraftbedrock
cd minecraftbedrock
docker build -t minecraftbedrock .
docker run -it --name minecraftbedrock --rm -p 19132:19132/udp -v ./server:/data/server -e level_seed=abc minecraftbedrock
```


# Update/Run

```
cd ~/minecraftbedrock
git pull
docker build -t minecraftbedrock .
docker rm -f minecraftbedrock
docker run -dit --name minecraftbedrock --restart unless-stopped -p 19132:19132/udp -v ./server:/data/server minecraftbedrock
docker logs -ft minecraftbedrock
```
