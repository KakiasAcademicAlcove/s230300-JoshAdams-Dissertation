# Docker

docker volume ls (show volumes)
docker volume rm <volume> (remove a volume)
docker volume rm -f <volume>
docker volume prune -f (clears stale volumes)
docker ps (show running containers)
docker ps -a (show all containers)
docker-compose down (delete containers)
docker-compose down -v (delete containers AND volumes)
docker-compose up --build 
docker-compose up --build -d
docker rm <container>
docker system prune -af (clears cached containers)
docker exec -it <container> /bin/bash (run a container)
docker image prune
docker exec -it freeradius1 /bin/bash
docker exec -it freeradius2 /bin/bash
docker exec -it freeradius3 /bin/bash
docker exec -it logstash /bin/bash
docker exec -it kafka-node-1 /bin/bash
docker exec -it kafka-node-2 /bin/bash
docker exec -it elasticsearch /bin/bash
docker exec -it kibana /bin/bash

# Chef 
cd /opt/cinc/cookbooks/freeradius/
chef-client --local-mode --override-runlist "recipe[freeradius::default]" --why-run
chef-client --local-mode --override-runlist "recipe[freeradius::default]"