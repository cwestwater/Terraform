terraform {

  required_version = ">= 1.6.2"

  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.5.1"
    }
  }
}

provider "vsphere" {
  user                 = "administrator@vsphere.local"
  password             = "VMware1!"
  vsphere_server       = "vcsa-01.localdomain"
  allow_unverified_ssl = true
}

resource "vsphere_custom_attribute" "built_by" {
  name                = "Built By"
  managed_object_type = "VirtualMachine"
}

resource "vsphere_custom_attribute" "repo" {
  name                = "Repo"
  managed_object_type = "VirtualMachine"
}