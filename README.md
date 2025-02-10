## LEARN DOCKER
### **DATA ENGINEERING - Learn Essential Docker Commands -**
Learn Docker, For this tutorial, Docker is installed in Windows WSL (Windows Subsystem for Linex) and it is used to access different docker images using Dockerfile and orchestrated multiple Dockerfiles using Docker compose.

### **What is Docker -**
*Docker is a containerization platform that allows developers to package, ship, and run applications in containers. Containers are lightweight and portable, and they provide a consistent and reliable way to deploy applications. Docker provides a way to create, deploy, and manage containers, and it supports a wide range of programming languages and frameworks.*

Think of it in this way, for installing DBT or Airflow, one will setup a server and install the required packages. Now if any other service needs to be installed, it will be installed on the same server. Now there might be issue with compatibility of certain common packages which is used by both these services. 

Docker solves this problem by creating a separate and isolated environment for each service. This way, each service can have its own environment and can be installed independently without affecting other services. This is the main advantage of Docker.

Docker community is very large and there are many pre-built images available in Docker Hub or other image repository, which can be used to create a container. These images can be used to create production-ready containers. 

Docker also provides a way to create custom images using ***Dockerfile***. Dockerfile is a text file that can be used to create a custom image. It contains a series of instructions that will be used to create a custom image. Dockerfile can be used to install packages, copy files, and set environment variables. 

These Dockerfiles can be used in ***Docker Compose*** to create multiple containers, Docker Compose helps to orchestrate multiple containers. It can be used to create a network of containers, and it can be used to manage the lifecycle of containers.


### **Following Services are covered -**
1. Dockerfile 
2. Docker Compose 
3. Docker Commands 


### **How to navigate through this Repo -**
1. Navigate to **`./dockerfile-config-dbt/README.md`**: This will help to understand basics of Dockerfile and how to build/ create image and start the container.
2. Navigate to **`./dockerfile-docker-compose-config-spark/README.md`**: This will help to understand basics of Dockerfile and Docker Compose and how to orchestrate multi container docker service.
3. Navigate to **`./docker-commands.md`**: This will help to understand common docker commands to build and manage the containers.

