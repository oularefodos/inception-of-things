sudo apt-get update && sudo apt-get upgrade -y

while [ ! -f /vagrant_data/node-token ]; do
    echo "Waiting for node-token..."
    sleep 5
done

# Change port 6444 ➔ 6443
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$(cat /vagrant_data/node-token) sh -s - --node-ip=192.168.56.111