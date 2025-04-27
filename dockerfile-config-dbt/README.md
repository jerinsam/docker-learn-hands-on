### Types of Docker Images
Docker image is a lightweight, standalone, and executable package that includes everything needed to run a piece of software
- **Bookworm** refers to the codename for the latest stable release of Debian.
- **Slim** indicates a minimal version of a Debian distribution with only the essential packages installed
- **Bullseye** is the codename for the previous stable Debian release
- **Alpine** is the “Dockerized” version of Alpine Linux


### Create Containers using Dockerfile
- **Dockerfile -** 
It is a text file that contains instructions for building a Docker image. It is used to create a Docker image from a Dockerfile. 
**Dockerfile Reference** - "docker-learn-hands-on/dockerfile-config-dbt/Dockerfile" 
    - **`FROM`** - specifies the base image to use for the new image. In this case, python :3.12-slim is used as the base image
    - **`WORKDIR`** - sets the working directory in the container to /usr/local/app
    - **`COPY`** - copies files from the current directory into the container at the specified path
      - **.dockerignore file**
        ```file
        # .dockerignore
        *.log
        *.tmp
        ```
        - The `.dockerignore` file is used to specify files and directories that should be excluded from the build context when building a Docker image.That means in case of any Copy activity in docker file, the files and directories specified in `.dockerignore` will not be copied to the image.
        - This file is similar to `.gitignore` in Git, where you can specify patterns for files and directories to ignore.
        - The `.dockerignore` file is placed in the root of the build context directory and is used by Docker to determine which files to exclude when building the image.
    - **`RUN`** - executes a command while creating the image. In this case, it installs the python packages mentioned in the requirements.txt file
    - **`CMD`** - specifies the default command to run when the container is started. In this case, CMD ["tail", "-f", "/dev/null"] is used to keep the container running indefinitely.
    - **`Volume`** - Specify the container path which will be mapped to the host machine path. In this case, the /usr/local/app directory is used. Docker will create an anonymous volume for this path. Refer to the section below for more details on volumes.
    - **`EXPOSE`** - Specifies the port that the container listens on. In this case, port 8080 is used. 
      - **Note** - `EXPOSE 8080` in the Dockerfile is optional. It documents that a process in the container will expose this port. But its required to actually expose the port with `-p` when running docker run. So, it is a best practice to also add EXPOSE in the Dockerfile to document this behavior.
  
  Each set of instructions in the Dockerfile is called a **Layer**. These layers are cached and will only be re-evaluted if the instruction changes. This makes the build process much faster. Creating a container from an image is also a layer.

  <img src="./readme-artifacts/layers.JPG" alt="dockerhub" width="600"/>

- **Difference between Entrypoint and CMD**

  |Feature|ENTRYPOINT|CMD|
  | -------- | ------- |-------- |
  | Purpose|Defines the main command|Provides default command/arguments|
  | Overridable?|No (unless --entrypoint is used)|Yes (can be overridden at runtime)|
  | Flexibility|Used for required commands|Used for default commands but can be overridden|
  | Example|ENTRYPOINT ["ping"]|CMD ["localhost"]|
  | Runtime Override|docker run my-container 8.8.8.8 (adds argument to Entrypoint)|docker run my-container ls (overwrites CMD Script)|

- **Using ENTRYPOINT and CMD Together**
When using both ENTRYPOINT and CMD, the ENTRYPOINT is used as the main command and the CMD will pass the arguments to ENTRYPOINT.

  Example - Consider below sample Dockerfile - 
  ```
  # Dockerfile
  FROM ubuntu
  ENTRYPOINT ["ping"]
  CMD ["localhost"]
  ```
  When the container is created and running, it will use the ENTRYPOINT script with the argument provided in the CMD. If the script needs to be executed with different argument, then CMD can be overridden at runtime.
  ```
  # Executing below docker command will run script "ping localhost" 
  # "ping" is the Entrypoint script and "localhost" is the argument provided in CMD
  docker run my-container
  ```
  ```
  # Executing below docker command will run script "ping 8.8.8.8" 
  # "ping" is the Entrypoint script and "8.8.8.8" is the CMD argument overidden at runtime
  docker run my-container 8.8.8.8
  ```

### Docker execution Commands 
  - Since Docker is installed in WSL, therefore open the WSL (Windows Subsystem for Linux) terminal and navigate to the directory where the Dockerfile is located.
  - Run the command to build the Docker image
    ```sh
    docker build -t <image-name> .
    ```
      - **docker build**: This is the command to initiate the image building process
      - **-t <image_name>**: This flag is used to tag the image with a name. This makes it easier to identify and reference the image later.
      - **.** : This indicates that the Dockerfile is located in the current directory.
    
    ``` 
    # Build dockerfile to create a new image
    docker build -t dbt_learn_image .
    ```
  - Run the command to create and run a new container from the Docker image
    ```sh
    docker run -p <docker_port>:<host_port> -it --rm -v "<host/folder : docker/folder >" --name <container-name> <image-name>
    ```   
      - **docker run**: This command is used to create a new container from the Docker image
      - **-it**: This flag is used to allocate a pseudo-TTY to the container and keep the container running even after the command is executed
      - **--rm**: This flag is used to automatically remove the container when it is stopped 
      - **-v "<host/folder : docker/folder>"**: This flag is used to mount a volume from the host machine to the container. This allows the container to access files from the host folder and vice versa. This same method is also used to map the named volume to the host machine. 
          - **Note** - The path of the host folder should be in the format `/mnt/c/path/to/folder` when using WSL (Windows Subsystem for Linux). This is because WSL uses a different file system structure than Windows.                 
      - **-p <docker_port>:<host_port>**: This flag is used to map a port from the host machine to the container. This allows the container machine to be accessed from the host machine.
      - **--name <container-name>**: This flag is used to specify the name of the container
      - **<image_name>** : This is the name of the Docker image created in the previous step
    
      ```sh
      # Run the container from the newly created image and mount the volume with host folder
      # while using WSL (Windows Subsystem for Linux), path should be in the format /mnt/c/path/to/folder
      # Syntax : docker run -it --rm -p 8080:8080 -v "/mnt/c/host/path:/usr/container/path" --name <container-name> <image-name>

      docker run -p 8080:8080 -v /mnt/c/host/path:/usr/container/path --name dbt-learn-hands-on dbt_learn_image
      
      ``` 
  - Start the shell of running container in Host machine using the following command
      ```sh
      # Get the container name or id by executing
      docker ps -a

      # Start the shell of running container in Host machine.
      docker exec -it <container_name_or_id> /bin/bash
      ```

  - **Details on Volumes**  
    - Whenever a Container is created , Docker creates a new filesystem for it. This is called a container filesystem or a container’s filesystem. This filesystem is isolated from the host system’s filesystem. This is a security feature. However, there's a limitation i.e. Container's data will be deleted between container restarts. 

    - Therefore, if data need to be persisted between container restarts then it can’t be done with the default container filesystem. To persist data between container restarts, a volume has to be mounted.

    - A volume is a directory outside of a container i.e. host machine's directory that is mounted into a container. This directory is managed by Docker. When a container is deleted, the volume is not deleted . When a container is restarted, the volume is preserved.

    - Volumes can be specified in Dockerfile, Docker Compose file, or during the `docker run` command. 
  
    - **Types of Persistent Storage - Mounted Directories**  
      - **Bind Mounts**
        - **Host Path ➝ Container Path**  
        - These mount local folders (on Windows machine) into the container at specific locations.  
          ```yaml
          - "/mnt/c/.../data:/usr/hive-metastore/data"
          - "/mnt/c/.../logs:/usr/hive-metastore/logs"
          - "/mnt/c/.../spark_apps:/usr/hive-metastore/spark-apps"
          ```
        - Docker run command with `-v` flag is used to mount the host directory into the container.
        ```sh
          docker run -p 8080:8080 -v /mnt/c/host/path:/usr/container/path --name dbt-learn-hands-on dbt_learn_image
        ```
        - While using Window's WSL (Windows Subsystem for Linux), Host path should be in the format /mnt/c/path/to/folder
      
      - **Named Volume**
        - Docker run command with `-v` flag is used to mount the named volume to a directory from the container.
            ```sh
              docker run -p 8080:8080 -v spark-logs:/opt/spark/spark-events --name dbt-learn-hands-on dbt_learn_image

              # spark-logs is the named volume created, which will be created by Docker
            ```
        - **`spark-logs:/opt/spark/spark-events`**  
          - Uses a **named volume** (`spark-logs`) for Spark event logs. 
          - Named Volume is a named directory that can be used in multiple containers. It is managed by Docker. When a container is deleted, the named volume is not deleted. When a container is restarted, the named volumne is preserved. 
          - Named volumes are stored on the host machine, but Docker manages them.
            - They are stored in Docker's volume directory (e.g., /var/lib/docker/volumes/ on Linux).
            - Unlike bind mounts, their exact location on the host is abstracted from the user.
          
        - ***NOTE: Named volumes can also be created using the `docker volume create` command. More details can be found in the docker-commands.md file in the root folder.***

      - **Anonymous Volume**
        - Volume mentioned in the Dockerfile is an anonymous volume. 
        - A volume mentioned in the Dockerfile or created during the `docker run` command without explicitly naming it is referred to as an anonymous volume.
        - Anonymous volumes are created and managed by Docker, but they do not have a name. These volumes persist data even after the container is removed 
        - Anonymous volumes are not automatically deleted when the container is stopped. Only when the container is deleted.
        - By default, anonymous volumes are stored in Docker's volume directory (e.g., `/var/lib/docker/volumes/` on Linux).
        - Unlike bind mounts, anonymous volumes' exact location on the host filesystem is abstracted from the user and managed by Docker.
        - Docker run command with `-v` flag and without a name is used to map anonymous volume. 
          ```sh
          docker run -v /data
          # This will create an anonymous volume in the container at /data
          ``` 

      - **Read-Only Volume**
        - Docker run command with `-v` flag and without a name is used to map anonymous volume. 
          ```sh
          docker run -v /host/path:/container/path:ro <image-name>
          # This will create a read-only volume in the container at /container/path
          ```
        - The `:ro` flag is used to specify that the volume should be mounted as read-only. This means that the container can read files from the volume, but cannot write to it. This is useful for scenarios where you want to share data with a container without allowing it to modify the data.
