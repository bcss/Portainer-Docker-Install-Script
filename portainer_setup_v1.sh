#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose plugin is available
if ! docker compose version &> /dev/null; then
    echo "Error: Docker Compose plugin is not available. Please install it."
    echo "For Ubuntu/Debian, run:"
    echo "  sudo apt-get install docker-compose-plugin"
    exit 1
fi

# Create directory structure
echo "Creating /opt/portainer for installation..."
sudo mkdir -p /opt/portainer/data
sudo chown -R 1000:1000 /opt/portainer

# Create docker-compose.yml
echo "Setting up docker-compose.yml..."
cat <<EOF | sudo tee /opt/portainer/docker-compose.yml > /dev/null
version: '3.8'

services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /opt/portainer/data:/data
    ports:
      - "9000:9000"
    command: -H unix:///var/run/docker.sock
EOF

# Start Portainer
echo "Starting Portainer..."
cd /opt/portainer
docker compose up -d

# Check if Portainer is running
if docker ps | grep -q "portainer"; then
    echo -e "\n✅ Portainer successfully installed!"
    echo -e "Access it at: \e[1mhttp://$(hostname -I | awk '{print $1}'):9000\e[0m"
    
    echo -e "\nManagement commands:"
    echo "  Stop Portainer:    cd /opt/portainer && docker compose down"
    echo "  Start Portainer:   cd /opt/portainer && docker compose up -d"
    echo "  View logs:         cd /opt/portainer && docker compose logs"
    echo "  Update Portainer:  cd /opt/portainer && docker compose pull && docker compose up -d"
else
    echo "❌ Error: Portainer failed to start. Check logs with:"
    echo "  docker logs portainer"
    exit 1
fi
