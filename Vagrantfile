# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "macOS_10_12_Sierra_vmware"

  config.vm.provider "vmware_fusion" do |v|
    v.gui = true
    v.vmx["memsize"] = "8192"
    v.vmx["numvcpus"] = 2
  end
end

