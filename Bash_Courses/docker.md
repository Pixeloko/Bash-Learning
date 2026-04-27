# Basic commands
```bash
docker ps # list runnning containers
docker run -d --name <image> # run in background
docker stop <container|$(docker ps -q)>
```

# Containers
display informations
```bash
docker inspect # JSON/all info about containers
docker inspect <container> --format 
docker inspect [-f|--format] "{{.Name}} - {{.NetworkSettings.Networks.public.IP4Address}}" # see the hierarchy tapping docker inspect <container>
docker ps --format "{{.Names}}" # see names of containers running
```

See IP of hosts in public network
```bash
docker inspect --format "{{.Name}} - {{.NetworkSettings.Networks.<public>.IPAddress}}" $(docker ps -q) 
```