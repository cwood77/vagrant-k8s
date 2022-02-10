# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
   #config.vm.define "starscream"

   config.vm.box = "hashicorp/bionic64"
   config.vm.box_version = "1.0.282"
   config.vm.hostname = "starscream"

   # k8s dashbaord
   config.vm.network "forwarded_port", guest: 8085, host: 8085
   # hello-minikube example
   config.vm.network "forwarded_port", guest: 8086, host: 8086

   # minikube et al. needs at least 2 CPUs
   # k8s requires <= 1800MB (1.8GB)
   config.vm.provider "virtualbox" do |vb|
      vb.cpus = 2
      vb.memory = 16 * 1024
      vb.name = "starscream"
   end

   config.vm.provision :shell, path: "provision.sh"
end
