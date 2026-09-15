# Basic commands
```bash
docker ps # list runnning containers
docker run -d --name <image> # run in background
docker run --tty --interactive <image> # run in terminal the image
docker stop <container|$(docker ps -q)>
```

run multiple containers with docker compose : `docker compose up -d`. You have to be located where the docker-compose.yaml file is.

# Containers
* `docker ps -q` display containers id
* 