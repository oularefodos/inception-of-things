sudo apt-get update && sudo apt-get upgrade -y
curl -sfL https://get.k3s.io | sh -s - --node-ip=192.168.56.110
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant_data/node-token
