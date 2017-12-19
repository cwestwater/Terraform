# Setup vSphere Provider and login
provider "vsphere" {
  user           = "user@corp.contoso.com"
  password       = "VMware1!"
  vsphere_server = "vcsa.corp.contoso.com"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}


# Data for Resources
data "vsphere_datacenter" "dc" {
  name = "Contoso"
}

data "vsphere_datastore" "datastore" {
  name          = "NFS-Datastore"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "iso_datastore" {
  name          = "NFS-Datastore"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "Terraform"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "2012R2-Template"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

/*
# Build a 2012 R2 VM
resource "vsphere_virtual_machine" "New-VM" {
  name             = "2012R2-VM"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 1
  memory   = 2048
  guest_id = "windows8Server64Guest"
  scsi_type = "lsilogic-sas"
  wait_for_guest_net_timeout = 0

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    name = "2012R2-VM.vmdk"
    size = 25
    thin_provisioned = true
  }

  cdrom {
    datastore_id = "${data.vsphere_datastore.iso_datastore.id}"
    path         = "ISO/2012r2.iso"
  }
}
*/

# Clone a 2012 R2 Template
resource "vsphere_virtual_machine" "Clone" {
  name             = "2012R2-Clone"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = 1
  memory   = 1024
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    name             = "2012R2-Clone.vmdk"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    
  }
}
