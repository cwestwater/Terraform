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

resource "vsphere_tag_category" "environment" {
  name        = "Environment"
  description = "What environment is the VM part of"
  cardinality = "SINGLE"

  associable_types = [
    "VirtualMachine",
  ]
}

resource "vsphere_tag" "prod" {
  name        = "PROD"
  category_id = vsphere_tag_category.environment.id
  description = "Production VM"
}

resource "vsphere_tag" "test" {
  name        = "TEST"
  category_id = vsphere_tag_category.environment.id
  description = "Test VM"
}

resource "vsphere_tag" "dev" {
  name        = "DEV"
  category_id = vsphere_tag_category.environment.id
  description = "Development VM"
}