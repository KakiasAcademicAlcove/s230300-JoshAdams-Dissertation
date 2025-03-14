Build an image with elk.

packer build freeradius.json
docker build -t freeradius:latest -f ./Dockerfile .
docker run -it freeradius:latest