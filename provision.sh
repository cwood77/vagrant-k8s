#!/bin/bash

# bail if any commands error out
set -e

echo =========================
echo ==       docker        ==
echo =========================
# using the 'repository' method [recommended]
# steps token from https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# sanity test
sudo docker run hello-world

echo =========================
echo ==      minikube       ==
echo =========================
# steps taken from https://minikube.sigs.k8s.io/docs/start/
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo =========================
echo ==    user account     ==
echo =========================
# setup alias for minikube as recommended by minikube docs
sudo cat >> ~/.bash_aliases << _EOF
alias kubectl="minikube kubectl --"
_EOF
# for for new users
sudo cat >> /etc/skel/.bash_aliases << _EOF
alias kubectl="minikube kubectl --"
_EOF
# prevents error from minikube talking to docker??
sudo chmod 666 /var/run/docker.sock
# minikube won't allow docker to run with privledge (best practice)
# so create a new account and switch to it
sudo useradd -m --groups docker -p $(perl -e 'print crypt($ARGV[0], "password")' 'vagrant') regularjoe
sudo -i -u regularjoe bash << EOF
set -e
minikube start
minikube kubectl -- get po -A
# publish the k8s dashboard
minikube dashboard --port=8085 --url=false
# run the minikube example and expose it
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.4
kubectl expose deployment hello-minikube --type=NodePort --port=8080
kubectl port-forward service/hello-minikube 8086:8080
EOF

echo Happy hacking
