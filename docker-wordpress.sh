#!/bin/bash
clear
cat << "EOF"

 ██████  ██████  ██████  ██████  ███    ██ ██████  ███████
██       ██   ██      ██      ██ ████   ██      ██      ██
██   ███ ██████   █████   █████  ██ ██  ██  █████      ██
██    ██ ██   ██      ██      ██ ██  ██ ██      ██    ██
 ██████  ██   ██ ██████  ██████  ██   ████ ██████     ██
		            https://github.com/gr33n37
		DOCKER,DOCKER-COMPOSE & WORDPRESS INSTALLATION
EOF

# Function to install Docker
install_docker() {
    echo "Docker is not installed. Installing Docker..."
    # Install Docker using the official script
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
    echo "Docker has been installed."
}

# Function to install Docker Compose
install_docker_compose() {
    echo "Docker Compose is not installed. Installing Docker Compose..."
    # Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose has been installed."
}

# Function to install WordPress
wordpress(){
  echo "
  version: "3"
services:
database:
image: mysql
restart: always
environment:
  MYSQL_ROOT_PASSWORD: wppassword
  MYSQL_DATABASE: wpdb
  MYSQL_USER: wpuser
  MYSQL_PASSWORD: wppassword
volumes:
  - mysql:/var/lib/mysql

wordpress:
depends_on:
  - database
image: wordpress:latest
restart: always
ports:
  - "80:80"
environment:
  WORDPRESS_DB_HOST: database:3306
  WORDPRESS_DB_USER: wpuser
  WORDPRESS_DB_PASSWORD: wppassword
  WORDPRESS_DB_NAME: wpdb
volumes:
  ["./:/var/www/html"]
volumes:
mysql: {}

  " > docker-compose.yml
}

install_wordpress() {
    echo "Installing WordPress..."
    # Use Docker Compose to deploy the WordPress and MySQL services
    echo "installation wil take some minutes"
    sudo docker-compose -f docker-compose.yml up -d
    echo -e "\e[1;32m WordPress has been installed. \e[0m"
}

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    install_docker
else
    echo -e "\n\e[1;35m Docker is already installed.\e[0m"
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    install_docker_compose
else
    echo -e "\n\e[1;33m Docker Compose is already installed. \e[0m\n"
fi

# Prompt to install WordPress
read -p "Do you want to install WordPress (y/n)? " choice
if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
    wordpress
    install_wordpress

fi
