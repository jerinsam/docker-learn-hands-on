## LEARN DOCKER
### **DATA ENGINEERING - Learn Essential Docker Commands -**
Learn Docker, For this tutorial, Docker is installed in Windows WSL (Windows Subsystem for Linex) and it is used to access different docker images using Dockerfile and orchestrated multiple Dockerfiles using Docker compose.

Refer below link to setup docker in WSL - 
https://gist.github.com/dehsilvadeveloper/c3bdf0f4cdcc5c177e2fe9be671820c7 


### **What is Docker -**
*Docker is a containerization platform that allows developers to package, ship, and run applications in containers. Containers are lightweight and portable, and they provide a consistent and reliable way to deploy applications. Docker provides a way to create, deploy, and manage containers, and it supports a wide range of programming languages and frameworks.*

Think of it in this way, for installing DBT or Airflow, one will setup a server and install the required packages. Now if any other service needs to be installed, it will be installed on the same server. Now there might be issue with compatibility of certain common packages which is used by both these services. 

Docker solves this problem by creating a separate and isolated environment for each service. This way, each service can have its own environment and can be installed independently without affecting other services. This is the main advantage of Docker.

#### Difference between Virtual Machine and Docker -
1. Virtual Machine (VM)
    - A VM is a virtualized computing environment that runs on a physical machine using a hypervisor.
    - Each VM has its own guest operating system, kernel, file system, and network stack.
    - VMs are more resource-intensive than containers because they include an entire OS and require hardware-level virtualization. However, VMs provide strong isolation between applications since each VM is independent.

2. Docker (Containers)
    - Docker allows applications to be packaged into containers, which are lightweight and portable.
    - Containers share the host OS kernel but maintain isolated user spaces.
    - They do not require a separate OS, making them faster, more efficient, and less resource-intensive than VMs.
    - Docker supports a wide range of programming languages and frameworks, making it highly versatile.

Docker community is very large and there are many pre-built images available in Docker Hub or other image repository, which can be used to create a container. These images can be used to create production-ready containers. 

Docker also provides a way to create custom images using ***Dockerfile***. Dockerfile is a text file that can be used to create a custom image. It contains a series of instructions that will be used to create a custom image. Dockerfile can be used to install packages, copy files, and set environment variables. 

These Dockerfiles can be used in ***Docker Compose*** to create multiple containers, Docker Compose helps to orchestrate multiple containers. It can be used to create a network of containers, and it can be used to manage the lifecycle of containers.


### **Following services are covered -**
1. Dockerfile 
2. Docker Compose 
3. Docker Commands 


### **How to navigate through this Repo -**
1. Navigate to **`./dockerfile-config-dbt/README.md`**: This will help to understand basics of Dockerfile and how to build/ create image and start the container and directory **`./dockerfile-config-dbt/`** will contain all the files related to Dockerfile.
2. Navigate to **`./dockerfile-docker-compose-config-spark/README.md`**: This will help to understand basics of Dockerfile and Docker Compose and how to orchestrate multi container docker service and directory **`./dockerfile-docker-compose-config-spark/`** will contain all the files related to Dockerfile, Docker Compose and necessary Docker Commands.
3. Navigate to **`./docker-commands.md`**: This will help to understand common docker commands to build and manage the containers.

