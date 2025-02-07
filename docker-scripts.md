docker build -t unity-catalog-image -f ./Dockerfile.unitycatalog .

docker ps --help

docker ps

docker compose up -d

docker compose up -d --scale <docker-service-name>=1

docker stop <container-name-or-id>

docker stop $(docker ps -aq)

docker image ls --help 

docker image ls

docker image rm dbt-learn-hands-on

docker container ls

docker container ls --help

docker container ls -a

docker container start <container-name-or-id>

docker container stop <container-name-or-id>

docker container rm $(docker ps -aq)

docker container rm -f $(docker container ls -aq)

docker image rm -f $(docker image ls -aq)

docker exec -it <container-name-or-id> /bin/bash 

docker compose build --no-cache && docker compose up -d --force-recreate

docker cp <host-path> <container-name-or-id>:<container-destination-path>

docker cp <container-name-or-id>:<container-source-path> <host-destination-path>
