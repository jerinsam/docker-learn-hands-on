# **Docker Commands Reference**


## **0. Show Help**
```sh
docker ps --help
```
- Displays help information for the `docker ps` command.
- `--help` flag is used to display help information for the command.

---

## **1. Build a Docker Image**

### **Build Docker Image**
```sh
docker build -t unity-catalog-image -f ./Dockerfile.unitycatalog .
```
- Builds a Docker image named `unity-catalog-image` using the specified Dockerfile (`./Dockerfile.unitycatalog`) in the current directory (`.`).
    - `-t` tags the image with a name.
    - `-f` specifies the Dockerfile to use.
    - `.` specifies build context i.e. which is the directory Docker will use to locate files

### **Start Docker Container**
```sh
docker run -p 8080:8080 -v /mnt/c/host/path:/usr/container/path --name dbt-learn-hands-on dbt_learn_image
```
- Runs a Docker container named `dbt-learn-hands-on` using the image `dbt_learn_image`.
    - `-p 8080:8080` maps port 8080 on the host to port 8080 inside the container.
    - `-v /mnt/c/host/path:/usr/container/path` mounts a volume, linking the host path `/mnt/c/host/path` to the container path `/usr/container/path`.
    - `--name dbt-learn-hands-on` assigns a custom name to the running container.
    - `dbt_learn_image` specifies the image to use for running the container.

---

## **2. Docker Process Management**

### **List Running Containers**
```sh
docker ps
```
- Shows currently running containers.

### **Inspect Images**
```sh
docker inspect dbt_learn_image
```
- Displays detailed information about the `dbt_learn_image` image like its configuration, history, and more.

### **Inspect Containers**
```sh
docker inspect dbt-learn-hands-on
```
- Shows information about the container `dbt-learn-hands-on` like its IP address, port mappings, and more.


---

## **3. Docker Compose Commands**

### **Start Containers in Detached Mode**
```sh
docker compose up -d
```
- Starts all services defined in `docker-compose.yml` in detached mode.

### **Scale a Specific Service**
```sh
docker compose up -d --scale <docker-service-name>=1
```
- Starts services with a specified number of instances.
- Replace `<docker-service-name>` with the actual service name.

### **Rebuild and Restart Containers**
```sh
docker compose build --no-cache && docker compose up -d --force-recreate
```
- Rebuilds all services without using cache.
- Forces recreation of containers even if no changes are detected.

---

## **4. Stopping Containers**

### **Stop a Running Container**
```sh
docker stop <container-name-or-id>
```
- Stops a running container.
- Replace `<container-name-or-id>` with the actual container ID or name.

### **Stop All Running Containers**
```sh
docker stop $(docker ps -aq)
```
- Stops all running containers.

---

## **5. Docker Image Management**

### **Show Help for `docker image ls`**
```sh
docker image ls --help
```
- Displays help information for listing Docker images.

### **List Available Docker Images**
```sh
docker image ls
```
- Shows all locally stored Docker images.

### **Remove a Specific Docker Image**
```sh
docker image rm dbt-learn-hands-on
```
- Deletes the `dbt-learn-hands-on` image.


### **Force Remove All Docker Images**
```sh
docker image rm -f $(docker image ls -aq)
```
- Force removes all images forcefully.

---

## **6. Docker Container Management**

### **List Running Containers**
```sh
docker container ls
```
- Shows all currently running containers.

### **Show Help for `docker container ls`**
```sh
docker container ls --help
```
- Displays help information for listing containers.

### **List All Containers (Including Stopped Ones)**
```sh
docker container ls -a
```
- Shows all containers, including stopped ones.

### **Start a Stopped Container**
```sh
docker container start <container-name-or-id>
```
- Starts a stopped container.

### **Stop a Running Container**
```sh
docker container stop <container-name-or-id>
```
- Stops a running container.

### **Remove All Stopped Containers**
```sh
docker container rm $(docker ps -aq)
```
- Removes all stopped containers.

### **Force Remove All Containers**
```sh
docker container rm -f $(docker container ls -aq)
```
- Force removes all containers, including running ones.

---

## **7. Execute Commands in a Running Container**
```sh
docker exec -it <container-name-or-id> /bin/bash
```
- Opens an interactive Bash shell inside a running container.

---

## **8. Copy Files Between Host and Container**

### **Copy from Host to Container**
```sh
docker cp <host-path> <container-name-or-id>:<container-destination-path>
```
- Copies files from the host system to the specified container.

### **Copy from Container to Host**
```sh
docker cp <container-name-or-id>:<container-source-path> <host-destination-path>
```
- Copies files from a container to the host system.

---


## **9. Docker Container Management**

### **List all Volumes**
```sh
docker volume ls
```
- List all Docker Volumes.


### **Delete specific volume**
```sh
docker volume rm <volume_name>
```
- Delete specific docker volume.


### **Remove all Docker Volumes**
```sh
docker volume rm $(docker volume ls -q)
```
- Removes all the volumes.


### **Delete all unused volumes**
```sh
docker volume prune
```
- Delete all unused volumes.


### **Force delete all unused volumes**
```sh
docker volume prune -f
```
- Force delete all unused volumes.

---
