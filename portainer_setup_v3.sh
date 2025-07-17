#!/bin/bash

# ================================
# Portainer Installer v3 (Enhanced)
# Compatible only with Ubuntu 22.04+
# ================================

# Default Configurations
DEFAULT_INSTALL_PATH="/opt/portainer"
DEFAULT_PORT="9000"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m'

# Trap to catch signals and clean up
trap 'echo -e "\n${RED}Script interrupted. Exiting...${NC}"; exit 1' INT TERM

# OS and Version Check
check_os() {
    if [[ "$(uname -s)" != "Linux" ]]; then
        echo -e "${RED}Error: This script only runs on Linux.${NC}"
        exit 1
    fi

    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" != "ubuntu" ]] || [[ "$VERSION_ID" != "22.04" ]]; then
            echo -e "${RED}Error: Only Ubuntu 22.04 is supported.${NC}"
            exit 1
        fi
    else
        echo -e "${RED}Error: Cannot determine OS version.${NC}"
        exit 1
    fi
}

# Check Docker & Compose Plugin
check_docker() {
    if ! command -v docker &>/dev/null; then
        echo -e "${YELLOW}Docker not found. Installing Docker...${NC}"
        curl -fsSL https://get.docker.com | sudo bash || {
            echo -e "${RED}Docker installation failed.${NC}"
            exit 1
        }
    fi

    if ! docker info &>/dev/null; then
        echo -e "${YELLOW}Starting Docker service...${NC}"
        sudo systemctl start docker || {
            echo -e "${RED}Failed to start Docker service.${NC}"
            exit 1
        }
    fi

    if ! docker compose version &>/dev/null; then
        echo -e "${YELLOW}Docker Compose plugin not found. Installing...${NC}"
        sudo apt-get update
        sudo apt-get install -y docker-compose-plugin || {
            echo -e "${RED}Docker Compose plugin installation failed.${NC}"
            exit 1
        }
    fi
}

# Check if Portainer is already installed
check_existing() {
    docker ps -a --format '{{.Names}}' | grep -q "^portainer$" && return 0
    [[ -d "$DEFAULT_INSTALL_PATH" ]] && return 0
    return 1
}

# Clean uninstall
uninstall() {
    echo -e "${YELLOW}Stopping and removing Portainer...${NC}"
    docker stop portainer &>/dev/null
    docker rm portainer &>/dev/null
    docker volume rm portainer_data &>/dev/null
    sudo rm -rf "$DEFAULT_INSTALL_PATH"
    echo -e "${GREEN}Uninstallation complete.${NC}"
}

# Install or reinstall Portainer
install() {
    check_docker

    read -p "Enter installation path [${DEFAULT_INSTALL_PATH}]: " input_path
    INSTALL_PATH="${input_path:-$DEFAULT_INSTALL_PATH}"

    read -p "Enter port number [${DEFAULT_PORT}]: " input_port
    PORT="${input_port:-$DEFAULT_PORT}"

    if [[ ! "$PORT" =~ ^[0-9]+$ ]] || ((PORT < 1 || PORT > 65535)); then
        echo -e "${RED}Invalid port. Must be between 1–65535.${NC}"
        exit 1
    fi

    if [[ -d "$INSTALL_PATH" || $(docker ps -a --format '{{.Names}}') =~ portainer ]]; then
        echo -e "${YELLOW}Portainer appears to be already installed.${NC}"
        read -p "Reinstall and wipe existing data? (y/N): " confirm
        [[ "$confirm" =~ ^[Yy]$ ]] || exit 0
        uninstall
    fi

    echo -e "${BLUE}Installing Portainer at $INSTALL_PATH on port $PORT...${NC}"
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

    cd "$INSTALL_PATH" && sudo docker compose up -d
    echo -e "${GREEN}Portainer is now running at http://<host>:$PORT${NC}"
}

# Main menu
show_menu() {
    echo -e "\n${BLUE}Portainer Management Menu${NC}"
    if check_existing; then
        echo "1. Reinstall Portainer"
        echo "2. Uninstall Portainer"
        echo "3. Exit"
        read -p "Select an option [1–3]: " choice
        case "$choice" in
            1) install ;;
            2) uninstall ;;
            3) exit 0 ;;
            *) echo -e "${RED}Invalid choice${NC}";;
        esac
    else
        echo "1. Install Portainer"
        echo "2. Exit"
        read -p "Select an option [1–2]: " choice
        case "$choice" in
            1) install ;;
            2) exit 0 ;;
            *) echo -e "${RED}Invalid choice${NC}";;
        esac
    fi
}

# Start Script
check_os
show_menu
