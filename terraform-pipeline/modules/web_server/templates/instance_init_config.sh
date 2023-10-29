sudo apt update -y
sudo usermod -aG docker $USER

sudo chmod 666 /var/run/docker.sock
sudo service docker start

sudo docker run -itd -p 8080:8081 -e CONNECTION_NAME=infernozen:asia-south1:petclinic-sql rosangcp/petclinic:8


