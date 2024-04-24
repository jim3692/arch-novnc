# arch-novnc
Docker container running ArchLinux accessible through novnc in a browser

# How To

## With Docker Hub

* `docker pull ghcr.io/jim3692/arch-novnc:latest`
* `docker run --rm -p 8083:8083 -ti --name arch-novnc ghcr.io/jim3692/arch-novnc:latest`
* `firefox http://localhost:8083/vnc.html`

## Build the container
`docker build -t ghcr.io/jim3692/arch-novnc .`

## Run the container
`docker run --rm -p 8083:8083 -ti --name arch-novnc ghcr.io/jim3692/arch-novnc:latest`

## Dive into the container
`docker exec -it arch-novnc /bin/bash`
