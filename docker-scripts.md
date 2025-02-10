# **Docker Commands Reference**

## **1. Build a Docker Image**
```sh
docker build -t unity-catalog-image -f ./Dockerfile.unitycatalog .
```
- Builds a Docker image named `unity-catalog-image` using the specified `Dockerfile.unitycatalog`.
- `-t` tags the image with a name.
- `-f` specifies the Dockerfile to use.
- `.` specifies build context i.e. which is the directory Docker will use to locate files

---

## **2. Docker Process Management**

### **Show Help for `docker ps`**
```sh
docker ps --help
```
- Displays help information for the `docker ps` command.

### **List Running Containers**
```sh
docker ps
```
- Shows currently running containers.

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

## **4. Stopping and Removing Containers**

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

### **Force Remove All Docker Images**
```sh
docker image rm -f $(docker image ls -aq)
```
- Deletes all images forcefully.

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
