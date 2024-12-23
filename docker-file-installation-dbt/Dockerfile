# FROM - specifies the base image to use for the new image. In this case, python :3.12-slim is used as the base image
FROM python:3.11.10-slim-bookworm

# WORKDIR - sets the working directory in the container to /usr/local/app
WORKDIR /usr/local/app

# COPY - copies files from the current directory into the container at the specified path
COPY ./requirements.txt .

# RUN - executes a command in the container. In this case, it installs the python packages mentioned in the requirement.
RUN apt-get update && apt-get install -y unixodbc-dev && \
    pip install --no-cache-dir -r requirements.txt

# Define a volume
VOLUME ["/usr/local/app/dbt-working-folder"]

# Keep the container running
CMD ["tail", "-f", "/dev/null"]
 