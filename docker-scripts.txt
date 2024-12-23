docker ps --help

docker ps

docker compose up -d

docker stop <container-name-or-id>

docker stop $(docker ps -aq)

docker image ls --help 

docker image ls

docker image rm dbt-learn-hands-on

docker container ls

docker container ls --help

docker container ls -a

docker container start <container-name-or-id>

docker exec -it <container-name-or-id> /bin/bash 

docker container stop <container-name-or-id>