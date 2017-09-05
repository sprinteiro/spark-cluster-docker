# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'


VAGRANTFILE_API_VERSION = "2"

# Multi-machine Vagrant setup
# Number of nodes in cluster. First one is the master.
$spark_num_instances = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    # Nodes definition - Cluster
    (1..$spark_num_instances).each do |i|
        config.vm.define "scale#{i}" do |scale|
            scale.vm.hostname = "scale#{i}.docker"
            scale.vm.synced_folder "./temp", "/scale-shared/", create: true
            
            scale.vm.provider "docker" do |d|
                d.build_dir = "."
                d.name = "scale#{i}"
                d.remains_running = true
                
                if "#{i}" == "1"
                    d.ports = [ "4040:4040", "7707:7707", "8080:8080" , "2222:22"]
                else
                    # Link worker to master
					d.create_args = [ "--link", "scale1:scale1.docker" ]
                end
            end
        end 
    end
end
