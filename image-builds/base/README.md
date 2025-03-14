Build a base ubuntu image with commonly used packages.

packer build ubuntu-base.json
docker build -t ubuntu-base:latest -f ./Dockerfile .
docker run -it ubuntu-base:latest