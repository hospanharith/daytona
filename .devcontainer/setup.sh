sudo dnf update -y
sudo dnf install git docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker $USER
# Download docker-compose
sudo mkdir -p /usr/local/lib/docker/cli-plugins
sudo curl -sL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m) -o /usr/local/lib/docker/cli-plugins/docker-compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
#Increase watcher limit
echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
# Download daytona
git clone https://github.com/hospanharith/daytona.git
cd daytona/.devcontainer && sudo docker compose -p daytona up -d