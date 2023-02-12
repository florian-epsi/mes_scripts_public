#!/bin/bash

# Vérification des droits d'administration (sudo)
if [ $(id -u) -ne 0 ]; then
    echo "Ce script doit être exécuté avec les droits d'administration (sudo)."
    exit 1
fi

# Mise à jour de la liste des packages
apt update

# Installation de Docker
apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && wait
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt install -y docker-ce docker-ce-cli containerd.io

# Ajout de l'utilisateur courant au groupe docker
usermod -aG docker $USER

# Redémarrage du daemon Docker
systemctl restart docker

# Installation de Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
