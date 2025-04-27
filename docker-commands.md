# **Docker Commands Reference**

## **0. Show Help**
```sh
docker ps --help
```
- Displays help information for the `docker ps` command.
- `--help` flag is used to display help information for the command.

---

## **1. Build a Docker Image**

### **Build Docker Image with name**
```sh
docker build -t unity-catalog-image -f ./Dockerfile.unitycatalog .
```
- Builds a Docker image named `unity-catalog-image` using the specified Dockerfile (`./Dockerfile.unitycatalog`) in the current directory (`.`). This will only create an image and won't create and start a container.
- `-t` tags the image with a name.
- `-f` specifies the Dockerfile to use.
- `.` specifies build context i.e. which is the directory Docker will use to locate files

### **Tag Docker Image with name and tag**
```sh
docker tag unity-catalog-image:latest unity-catalog-image:1.0.0
```
- Tags the existing image `unity-catalog-image:latest` with a new tag `1.0.0`. 
- This command allows to create multiple tags for the same image, enabling versioning and organization of images.
- The `docker tag` command creates a new tag for the image without creating a new image, allowing to reference the same image with different tags.

### **Build Docker Image with name and tag**
```sh
docker build -t unity-catalog-image:latest -f ./Dockerfile.unitycatalog .
```
- Builds a Docker image named `unity-catalog-image:latest` using the specified Dockerfile (`./Dockerfile.unitycatalog`) in the current directory (`.`). This will only create an image and won't create and start a container.
- `-t` tags the image with a name and tag.
    - `unity-catalog-image` is the name of the image.
    - `latest` is the tag for the image, which is commonly used to indicate the most recent version of the image.
- `-f` specifies the Dockerfile to use.
- `.` specifies build context i.e. which is the directory Docker will use to locate files


### **Create and Start Docker Container**
```sh
docker run -p 8080:8080 -v /mnt/c/host/path:/usr/container/path -d --rm --network <network-name> --name dbt-learn-hands-on dbt_learn_image
```
- Runs a Docker container named `dbt-learn-hands-on` using the image `dbt_learn_image`.
    - `-p 8080:8080` maps port 8080 on the host to port 8080 inside the container.
    - `-v /mnt/c/host/path:/usr/container/path` mounts a volume, linking the host path `/mnt/c/host/path` to the container path `/usr/container/path`.
    - `--name dbt-learn-hands-on` assigns a custom name to the running container.
    - `dbt_learn_image` specifies the image to use for running the container.
    - `-d` runs the container in detached mode (in the background), allowing to continue using the terminal. Executing the command without `-d` will run the container in the foreground, blocking the terminal until the container stops.
    - `--rm` automatically removes the container when the container is stopped or exits.
    - `--network <network-name>` specifies the network to which the container will be connected. Details of Docker Network can be found in below section.
    
### **Start a existing Docker Container**
```sh
docker start dbt-learn-hands-on
```
- This command will start the container which already exists.

### **Attach and Detach Mode**
```sh
docker attach dbt-learn-hands-on
```
- This command will attach to the running container `dbt-learn-hands-on`, allowing to view container logs direcly in host terminal.
- Attach mode starts the container and dont allow user to execute any further command in the terminal, attach mode allows to view container logs direcly in host terminal for example, whatever prints in the container terminal will be shown in host terminal.
- While detach mode runs the container in the background, `-d` flag in `docker run` or `docker compose` command is used to run the container in detach mode, allowing user to execute any further command in the terminal.
- To detach from the container running in attached mode, user can use the `Ctrl + P` followed by `Ctrl + Q` key combination, this will detach from the container's terminal without stopping it.
- To view the logs of a detached or specific container, docker logs command can be used, which is mentioned in the below section. 

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
- This command will show the detailed information about the image `dbt_learn_image` like its configuration, history, and more.
- The output will include information such as the image ID, creation date, size, environment variables, exposed ports, and more.

### **Inspect Containers**
```sh
docker inspect dbt-learn-hands-on
```
- This command will show detailed information about the container `dbt-learn-hands-on` like its IP address, port mappings, and more.
- The output will include information such as the container ID, status, network settings, and more.


---

## **3. Docker Compose Commands**

### **Start Containers in Detached Mode**
```sh
docker compose up -d
```
- Starts all services defined in `docker-compose.yml` in detached mode.
- `-d` flag runs the containers in detach mode i.e runs the container in the background. Executing the command without `-d` will run the container in the foreground, blocking the terminal until the container stops.

### **Scale a Specific Service**
```sh
docker compose up -d --scale <docker-service-name>=1
```
- Starts services with a specified number of instances.
- Replace `<docker-service-name>` with the actual service name.
- `-d` flag runs the containers in detach mode i.e runs the container in the background. Executing the command without `-d` will run the container in the foreground, blocking the terminal until the container stops.
- `--scale` flag specifies the number of instances to run for a specific service.
- `1` specifies the number of instances to run for the specified service.

### **Rebuild and Restart Containers**
```sh
docker compose build --no-cache && docker compose up -d --force-recreate
```
- Rebuilds all services without using cache.
- Forces recreation of containers even if no changes are detected.
- `-d` flag runs the containers in detach mode i.e runs the container in the background.
- `--no-cache` flag forces Docker to build the image without using any cache.
- `--force-recreate` flag forces Docker to recreate the containers even if no changes are detected.

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
- `$(docker ps -aq)` retrieves the IDs of all containers.

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
- The output will include the repository name, tag, image ID, creation date, and size of each image.
- The `REPOSITORY` column shows the name of the image, which can be used in other Docker commands to reference the image.
- The `TAG` column shows the tag of each image, which is commonly used to indicate the version of the image. The `latest` tag is often used to indicate the most recent version of the image.
- The `IMAGE ID` column shows the unique identifier for each image, which can be used in other Docker commands to reference the image.

### **Remove a Specific Docker Image - Method 1**
```sh
docker image rm dbt-learn-hands-on
```
- Deletes the `dbt-learn-hands-on` image.

### **Remove a Specific Docker Image - Method 2**
```sh
docker rmi <image-name-or-id>
```
- Deletes the specified image.


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


### **Prune All Containers**
```sh
docker container prune -f
```
- Force removes all unused containers.
- `-f` flag forces the removal of all stopped containers without prompting for confirmation.

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

## **9. Docker Volume Management**
More details on Docker volumes can be found in "dockerfile-config-dbt/README.md" and "dockerfile-docker-compose-config-spark/README.md" files.

### **List Docker Volumes**
```sh
docker volume ls
```
- Lists all Docker volumes.
- This command will show all the volumes created by Docker, including the default volumes created by Docker for its internal use and any custom volumes created by the user or other applications.
- The output will include the volume name and driver of each volume.
- The `local` driver is the default driver used by Docker for creating volumes on the host filesystem.
- The output will look something like this:
```sh   
VOLUME NAME          DRIVER              SIZE
a1b2c3d4e5f6        local               10GB    
a1b2c3d4e5f6        local               5GB
a1b2c3d4e5f6        local               20GB
```
- The `local` driver is the default driver used by Docker for creating volumes on the host filesystem.
- The `SIZE` column shows the size of each volume, which can be useful for monitoring disk usage and managing storage resources.
- The `VOLUME NAME` column shows the name of each volume, which can be used in other Docker commands to reference the volume.
- The `DRIVER` column shows the driver used for each volume, which can be useful for understanding how the volume is created and managed.

- **Docker Volume Driver Types**:

    | Driver  | Description |
    |---------|-------------|
    | local   | Default driver for creating volumes on the host filesystem. |
    | tmpfs   | In-memory filesystem driver for creating temporary volumes that live in RAM and disappear after the container stops. |
    | nfs     | Volume driver using the Network File System (NFS); typically set up using plugins or manual configuration. |
    | s3      | Third-party volume driver for creating volumes on Amazon S3 storage (requires external plugin). |
    | azure   | Third-party volume driver for creating volumes on Azure Blob storage (requires external plugin). |
    | gcs     | Third-party volume driver for creating volumes on Google Cloud Storage (requires external plugin). |
    | ceph    | Volume driver using Ceph distributed storage (requires external plugin). |
    | gluster | Volume driver using GlusterFS distributed storage (requires external plugin). |
    | portworx| Volume driver for managing container storage with Portworx (requires external plugin). |
    | rexray  | Volume driver supporting various cloud and storage platforms through REX-Ray (requires external plugin). |

### **Create a Docker Volume**
```sh
docker volume create <volume-name> 
```
- When a Docker volume is created using the default local driver, Docker stores the volume data on the host filesystem.
- This command will create a new volume using the default `local` driver, which allows containers to share data between them and persist data even after the container is stopped or removed.
- Replace `<volume-name>` with the desired name for your volume.
- The command will return the name of the newly created volume.
- The volume name is a unique identifier for the volume and can be used in other Docker commands to reference the volume.
- The volume can be used to store data that needs to persist beyond the lifecycle of a single container, such as database files, application logs, or configuration files.
- The volume can be mounted to one or more containers, allowing them to read and write data to the same location on the host filesystem.
- The volume can also be shared between multiple containers, allowing them to access the same data without duplicating it on the host filesystem.


### **Remove a Specific Volume**
```sh
docker volume rm -f <volume-name>
```
- Removes a specific Docker volume.
- Replace `<volume-name>` with the name of the volume to be removed.
- This command will delete the specified volume and all its associated data.
- The `-f` flag forces the removal of the volume, even if it is currently in use by a container.
- If the volume is in use by a container, the command will fail without the `-f` flag.


### **Attach a Volume to a Container**
```sh
docker run -v <volume-name>:/path/in/container <image-name>
```
- Attaches a specified volume to a container at a specific path inside the container.
- Replace `<volume-name>` with the name of the volume, `/path/in/container` with the desired path inside the container, and `<image-name>` with the name of the image to run.
- `-v` flag mounts the volume to the specified path inside the container.


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

## **10. Docker Logs**

### **To access docker container logs**
```sh
docker logs <container-name-or-id> -f
```
- View the logs of a specific container in real-time.
- `-f` flag follows the log output, allowing to see new log entries as they are written.
- Replace `<container-name-or-id>` with the actual container ID or name.


---

## **11. Docker Network Management**
Details on the Docker Network Access Scenarios can be found in "dockerfile-docker-compose-config-spark/README.md" files.

### **List Docker Networks**
```sh
docker network ls
```
- Lists all Docker networks.
- This command will show all the networks created by Docker, including the default networks like `bridge`, `host`, and `none`.
- It will also show any custom networks created by the user or other applications.
- The output will include the network name, ID, driver, and scope of each network.
- The `bridge` network is the default network created by Docker for containers to communicate with each other. The `host` network allows containers to share the host's network stack, while the `none` network isolates the container from any network.
- The output will look something like this:
```sh   
NETWORK ID          NAME                DRIVER              SCOPE
a1b2c3d4e5f6        bridge              bridge              local
a1b2c3d4e5f6        host                host                local
a1b2c3d4e5f6        none                null                local
a1b2c3d4e5f6        my_custom_network   bridge              local
```
- Driver and Scope are two important attributes of Docker networks:
- **Driver**: The network driver determines how the network is created and how containers communicate over it. Docker supports several network drivers, including `bridge`, `host`, `none`, `overlay`, `macvlan`, and `ipvlan`. Each driver has its own use case and behavior.

    | Driver  | Description |
    |---------|-------------|
    | bridge  | Default network driver for communication between containers on the same host. |
    | host    | Allows containers to share the host's network stack directly. |
    | none    | Completely isolates the container from any network. |
    | overlay | Enables communication between containers across multiple Docker hosts, typically used in a swarm cluster. |
    | macvlan | Assigns a MAC address to a container, allowing it to appear as a physical device on the network. |
    | ipvlan  | Assigns an IP address to a container from the parent's network interface, enabling communication at the IP layer. |


- **Scope**: The scope of a network determines its visibility and accessibility. Docker networks can have different scopes, such as `local`, `global`, or `swarm`. The scope defines whether the network is accessible only on the host where it was created or across multiple hosts in a Docker swarm.
    | Scope  | Description |
    |--------|-------------|
    | local  | The network is only accessible on the host where it was created. |
    | global | The network is accessible across all nodes in a Docker swarm. |
    | swarm  | The network is used in a Docker swarm to allow communication between services across multiple nodes. |

### **Create a Docker Network**
```sh
docker network create --driver bridge <network-name>
```
- Creates a new Docker network with the specified name and driver.
- Replace `<network-name>` with the desired name for your network.
- `--driver bridge` specifies the network driver to use for the new network (if driver is not specified, docker will use default driver i.e. bridge). This allows containers to communicate with each other on the same host.
- The command will return the network ID of the newly created network.
- The network ID is a unique identifier for the network and can be used in other Docker commands to reference the network.

### **Attach a Container to a Network**
```sh
docker network connect <network-name> <container-name-or-id>
``` 
- Connects a running container to a specified network.
- Replace `<network-name>` with the name of the network and `<container-name-or-id>` with the name or ID of the container.
- This command allows the container to communicate with other containers on the same network.

### **Detach a Container from a Network**
```sh
docker network disconnect <network-name> <container-name-or-id>
```
- Disconnects a running container from a specified network.
- Replace `<network-name>` with the name of the network and `<container-name-or-id>` with the name or ID of the container.
- This command will remove the container from the network, preventing it from communicating with other containers on that network.

### **Remove a Docker Network**
```sh
docker network rm <network-name> 
```
- Removes a specified Docker network.
- Replace `<network-name>` with the name of the network to be removed.
- This command will delete the network and all its associated resources.
- If there are any containers connected to the network then this command will fail.  

---

## **12. Docker Container Interactive Mode (Access terminal of the Container)**
### **Start a Container and access the terminal**
```sh
docker run -it <image-name> /bin/bash
```
- Runs a container in interactive mode, allowing to execute commands inside the container.
- Replace `<image-name>` with the name of the image to run.
- `-it` flag combines `-i` (interactive) and `-t` (pseudo-TTY) to provide an interactive terminal session.
- `/bin/bash` specifies the command to run inside the container, which opens a Bash shell.
- This command will start a new container from the specified image and open a Bash shell inside it, allowing to execute commands directly in the container's environment.
- `docker run` command has other options which is described in above section.

### **Access the terminal of the running container**
```sh
docker exec -it <container-name-or-id> /bin/bash
```
- Opens an interactive Bash shell inside a running container.
- `-it` flag combines `-i` (interactive) and `-t` (pseudo-TTY) to provide an interactive terminal session.
- Replace `<container-name-or-id>` with the actual container ID or name.
- This command allows to execute commands directly in the container's environment without starting a new container. 

---

## **13. Docker Registry Management**
### **Login to Docker Registry**
```sh
docker login <registry-url>
```
- Logs in to a specified Docker registry.
- Replace `<registry-url>` with the URL of the registry to log in to.
- This command will prompt for a username and password to authenticate with the registry.
- The Docker registry is a service for storing and distributing Docker images. It can be a public registry like Docker Hub or a private registry hosted on your own infrastructure.
- Logging in to a registry allows to push and pull images from that registry, enabling collaboration and sharing of images with other users or teams.
- The command will store the authentication credentials in the Docker configuration file, allowing to access the registry without entering credentials each time.
- The credentials are stored in the `~/.docker/config.json` file on the host system, which is used by Docker to authenticate with the registry.

### **Push an Image to a Registry**
```sh
docker push <registry-url>/<image-name>:<tag>

# e.g. docker push registry.example.com/my-image:latest

```
- Pushes a specified image to a Docker registry, making it available for other users or teams to pull and use.
- Replace `<registry-url>` with the URL of the registry, `<image-name>` with the name of the image, and `<tag>` with the desired tag for the image.
- The image must be tagged with the registry URL before pushing it, using the `docker tag` command. 
    ```sh
    docker tag <image-name> <registry-url>/<image-name>:<tag>
    
    # e.g. docker tag localimage registry.example.com/my-image:latest
    ```
    - Replace `<image-name>` with the name of the image, `<registry-url>` with the URL of the registry, and `<tag>` with the desired tag for the image.
    - This command will create a new tag for the image that includes the registry URL, allowing to push the image to the specified registry.
- The `docker push` command will check if the image already exists in the registry and only upload the layers that are not already present, optimizing the upload process.
- The command will also check for any dependencies or base images required by the image being pushed and ensure they are also available in the registry.
- The image can be pushed to a public registry like Docker Hub or a private registry hosted on your own infrastructure.

### **Pull an Image from a Registry**
```sh
docker pull <registry-url>/<image-name>:<tag>

# e.g. docker pull registry.example.com/my-image:latest

```
- Pulls a specified image from a Docker registry.
- Replace `<registry-url>` with the URL of the registry, `<image-name>` with the name of the image, and `<tag>` with the desired tag for the image.
- This command will download the specified image from the registry to the local Docker host, making it available for use.
- The image can be pulled from a public registry like Docker Hub or a private registry hosted on your own infrastructure.

