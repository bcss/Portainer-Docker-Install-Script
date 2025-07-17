#!/bin/bash

# Configuration
DEFAULT_INSTALL_PATH="/opt/portainer"
DEFAULT_PORT="9000"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check if Portainer exists
check_existing() {
  # Check for container
  if docker ps -a --format '{{.Names}}' | grep -q "portainer"; then
    echo -e "${YELLOW}⚠️  Portainer container detected${NC}"
    return 0
  fi
  
  # Check for installation directory
  if [ -d "$DEFAULT_INSTALL_PATH" ]; then
    echo -e "${YELLOW}⚠️  Portainer directory found at $DEFAULT_INSTALL_PATH${NC}"
    return 0
  fi

  return 1
}

# Main menu with dynamic options
show_menu() {
  echo -e "\nPortainer Management Script"
  
  if check_existing; then
    echo -e "${YELLOW}1. Reinstall Portainer (clean install)${NC}"
    echo -e "${RED}2. Uninstall Portainer${NC}"
    echo "3. Exit"
    MAX_CHOICE=3
  else
    echo "1. Install Portainer"
    echo "2. Exit" 
    MAX_CHOICE=2
  fi

  while true; do
    read -p "Choose [1-$MAX_CHOICE]: " choice
    case $choice in
      1) install ;;
      2) if check_existing; then uninstall; else exit; fi ;;
      3) if [ $MAX_CHOICE -eq 3 ]; then exit; fi ;;
      *) echo -e "${RED}Invalid option${NC}"; continue ;;
    esac
    break
  done
}

# Check if Docker is running
check_docker() {
    if ! docker info &>/dev/null; then
        echo -e "${RED}Error: Docker is not running. Please start Docker first.${NC}"
        exit 1
    fi
}

# Clean Portainer artifacts (containers, volumes, networks)
clean_portainer() {
    echo -e "${YELLOW}Removing Portainer stack...${NC}"
    cd "$INSTALL_PATH" 2>/dev/null && docker compose down --volumes --rmi local 2>/dev/null
    
    echo -e "${YELLOW}Cleaning residual resources...${NC}"
    docker rm -f portainer 2>/dev/null
    docker volume rm -f portainer_data 2>/dev/null
    sudo rm -rf "$INSTALL_PATH"
    echo -e "${GREEN}Portainer cleanup complete!${NC}"
}

# Install Portainer
install() {
    check_docker
    
    read -p "Enter installation path [$DEFAULT_INSTALL_PATH]: " user_path
    INSTALL_PATH=${user_path:-$DEFAULT_INSTALL_PATH}
    
    read -p "Enter port number [$DEFAULT_PORT]: " user_port
    PORT=${user_port:-$DEFAULT_PORT}
    
    # Reinstall check
    if [ -d "$INSTALL_PATH" ]; then
        echo -e "${YELLOW}Portainer already exists at $INSTALL_PATH${NC}"
        read -p "Reinstall? (will delete existing Portainer data) [y/N]: " reinstall
        if [[ ! "$reinstall" =~ ^[Yy] ]]; then exit; fi
        clean_portainer
    fi
    
    echo -e "${YELLOW}Installing Portainer to $INSTALL_PATH...${NC}"
    sudo mkdir -p "$INSTALL_PATH/data"
    sudo chown -R 1000:1000 "$INSTALL_PATH"
    
    cat <<EOF | sudo tee "$INSTALL_PATH/docker-compose.yml" >/dev/null
version: '3.8'
services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: unless-stopped
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - $INSTALL_PATH/data:/data
    ports:
      - "$PORT:9000"
EOF

    cd "$INSTALL_PATH" && docker compose up -d
    
    if docker ps | grep -q "portainer"; then
        echo -e "\n${GREEN}✅ Portainer running at http://$(hostname -I | awk '{print $1}'):$PORT${NC}"
    else
        echo -e "${RED}❌ Failed to start. Check logs: docker logs portainer${NC}"
    fi
}

# Uninstall Portainer
uninstall() {
    read -p "Enter Portainer installation path [$DEFAULT_INSTALL_PATH]: " user_path
    INSTALL_PATH=${user_path:-$DEFAULT_INSTALL_PATH}
    
    if [ ! -d "$INSTALL_PATH" ]; then
        echo -e "${RED}Error: No Portainer installation found at $INSTALL_PATH${NC}"
        exit 1
    fi
    
    echo -e "${YELLOW}This will permanently delete Portainer and all its data!${NC}"
    read -p "Continue? [y/N]: " confirm
    [[ "$confirm" =~ ^[Yy] ]] || exit 0
    
    clean_portainer
    echo -e "${GREEN}Portainer uninstalled. Docker and Docker Compose remain intact.${NC}"
}

# Main menu
echo -e "\nPortainer Management Script"
echo "1. Install/Reinstall Portainer"
echo "2. Uninstall Portainer"
echo "3. Exit"

read -p "Choose [1-3]: " choice

case $choice in
    1) install ;;
    2) uninstall ;;
    3) exit 0 ;;
    *) echo -e "${RED}Invalid option${NC}"; exit 1 ;;
esac
