# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "macOS_10_12_sierra_vmware"

  if Vagrant.has_plugin?("vagrant-timezone")
    # match host timezone
    # can use explicit values from TZ database, e.g.
    # config.timezone.value = "Europe/London"
    config.timezone.value = :host
  end

  # Configure guest metal here
  config.vm.provider "vmware_fusion" do |v|
    v.gui = true
    v.vmx["memsize"] = "8192"
    v.vmx["numvcpus"] = 2
  end
end

