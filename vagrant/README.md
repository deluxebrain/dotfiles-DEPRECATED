# Testing with Packer and Vagrant

## Prerequisites

### Packer

TODO

### Vagrant

1.  vagrant-vnware-fusion plugin

    Note this is a licensed product - separate to the actual VMWare fustion software.

    ```sh
    vagrant plugin install vagrant-vmware-fusion
    vagrant plugin license vagrant-vmware-fusion <path_to_license>
    ```

## Basic Vagrant setup

Create directory structure to hold ISOs and hypervisor/vagrant images outside of specific repositories. Note the use of the `/var` directory - this is intended to be mounted on the non-system disk.

```sh
/var/media/images/vagrant
/var/media/images/vbox
/var/media/images/fusion
/var/media/iso
```

By default the VMWare provider will clone the vn into the `.vagrant` directory relative to the location of the `Vagrantfile`.
This can be overriden with the `VAGRANT_VMWARE_CLONE_DIRECTORY` environment variable. Note this variable does not need to be unique per project.

## Preparing the MacOS installer for use with Packer and Vagrant

Dowloaad MacOS installer to `/var/media/iso` directory.

Clone _osx-vm-templates_ git repository. Note - the best practice is to use the packer builds as application agnostic base builds. In this way - the image configurations are geared towards the requirements for the baking process - not any specific application usage of the build. Any additional configuration of the images for any application specific requirements are there done through the `vagrantfile`. This means that it should not be necessary to make any alterations to the actual template repository. 

The native MacOS installer does not support bootstrapping via vagrant. The `prepare_iso.sh` script exists to perform modifications to the image to this end.

```sh
sudo prepare_iso/prepare_iso.sh <path_to_source> <output directory>
# e.g. 
# sudo prepare_iso/prepare_iso.sh "/var/media/iso/Install macos Sierra.xpp/" /var/media/iso/prepared"
```

This defaults the image to use `vagrant` for the username and password of the admin user installed by the script. Use `-u` and `-p` to override this.

## Creating the Vagrant box image

1.  Run packer to create the base MacOS vagrant image. 

    Note the provisioning delay of 30 seconds is recommended for any subsequent provisioning steps that involve Internet downloads.

    ```sh
    cd packer
    packer build --only vmware-iso \
      --var iso="/var/media/iso/prepared/OSX_InstallESD_10.12_16A323.dmg" \
      --var provision_delay=30 \
      template.json
    mv packer_vmware-iso_vmware.box /var/media/images/vagrant/macOS_10_12_sierra_vmware.box
    ```

2.  Add the box to vagrant

    ```sh
    vagrant box add /var/media/images/vagrant/macOS_10_12_sierra_vmware.box --name macOS_10_12_sierra_vmware
    vagrant box list
    vagrant box remove <name> # to remove, if and when required
    ```

## Vagrantfile

Make any environment specific changes to the Vagrantfile.

To show the number of logical cores on the host box

```sh
sysctl -n hw.ncpu
```

## Basic Vagrant usage

```sh
vagrant up
vagrant suspend
vagrant resume
vagrant reload # use if changes made to the Vagrantfile
vagrant halt # bring back up with a vagrant up
vagrant destroy
```

## Managing running Vagrant instances

Show state of all active Vagrant environments for the current user.

```sh
vagrant global-status
```
