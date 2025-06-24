# Docker

docker volume ls (show volumes)
docker volume rm <volume> (remove a volume)
docker volume rm -f <volume>
docker volume prune -f (clears stale volumes)
docker system prune --volumes
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

## FreeRADIUS
# Auth
radtest testuser password 127.0.0.1 1812 testing123

# Acct
cd /etc/freeradius && radclient localhost acct testing123 < acct-start.txt
cd /etc/freeradius && radclient localhost acct testing123 < acct-stop.txt

# Both
cd /etc/freeradius/test && ./test_data_generator.sh

# Git - reset a commit
git reset HEAD^

# Kafka
cd /opt/kafka/bin && ./kafka-topics.sh --create --topic freeradius_auth_accept --bootstrap-server kafka-1:9092 --partitions 3 --replication-factor 1

cd /opt/kafka/bin && ./kafka-console-consumer.sh --bootstrap-server kafka-1:9092 --topic freeradius_acct --from-beginning --consumer.config /etc/kafka/secrets/kafka-1-ssl.properties

cd /opt/kafka/bin && ./kafka-topics.sh --bootstrap-server kafka-1:9092 --list

# Kibana
View indexes - http://localhost:5601/app/management/data/index_management/indices