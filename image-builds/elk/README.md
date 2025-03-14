Build an image with elk.

packer build elk.json
docker build -t elk:latest -f ./Dockerfile .
docker run -it elk:latest