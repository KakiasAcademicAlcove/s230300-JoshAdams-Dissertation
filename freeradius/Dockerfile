FROM freeradius/freeradius-server:latest

# Install Chef (Omnibus installer)
RUN apt-get update && apt-get install -y curl
RUN curl -L https://omnitruck.chef.io/install.sh | bash

# Expose necessary ports
EXPOSE 1812/udp 1813/udp

CMD ["freeradius", "-X"]