# Vagrant-k8s
A minimal vagrant/virtual box setup for docker, minikube, and kubernetes on Ubuntu

# Open Issues
- Still wrestling with getting the minikube dashboard to work.  There are some known issues around this on stackoverflow et al. that I haven't processed yet.

# What's Included
- ubuntu
- docker
- minikube
- that's it

# What you might want to tweak
- I'm exposing specific ports for the dashboard and `hello-minikube` test deployment you might want to adjust

# Setup
1. Install VirtualBox and Vagrant
1. Open a command prompt beside the `Vagrantfile`
1. Issue `vagrant up`
1. Navigate to http://localhost:8085 for the kubernetes dashboard and/or http://localhost:8086 for the `hello-minikube` demo
