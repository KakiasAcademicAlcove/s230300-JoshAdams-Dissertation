Build an image with elk.

packer build kafka.json
docker build -t kafka:latest -f ./Dockerfile .
docker run -it kafka:latest