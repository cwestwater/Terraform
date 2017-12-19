# Setup vSphere Provider and login
provider "vsphere" {
  user           = "${var.username}"
  password       = "${var.password}"
  vsphere_server = "${var.vcenter}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}


# Data for Resources
data "vsphere_datacenter" "dc" {
  name = "${var.datacenter}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "iso_datastore" {
  name          = "${var.iso_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "${var.pool}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

# Build a 2012 R2 VM
resource "vsphere_virtual_machine" "New-VM" {
  name             = "${var.vmname}"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  guest_id = "${var.ostype}"

  wait_for_guest_net_timeout = "${var.timeout}"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  disk {
    name = "${var.diskname}"
    size = "${var.size}"
  }

  cdrom {
    datastore_id = "${data.vsphere_datastore.iso_datastore.id}"
    path = "${var.iso}"
  }
}
