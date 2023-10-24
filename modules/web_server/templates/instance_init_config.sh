sudo apt update -y
export ENDPOINT=$1
sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock
sudo service docker start

sudo docker run -itd -p 8080:8081 -e CONNECTION_NAME=$ENDPOINT rosangcp/petclinic:8


