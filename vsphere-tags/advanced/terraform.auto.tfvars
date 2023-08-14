vsphere_server   = "vcsa-01.localdomain"
vsphere_user     = "administrator@vsphere.local"
vsphere_password = "VMware1!"
tags = {
  prod = {
    tag_name        = "PROD"
    tag_description = "Production VM"
  }

  test = {
    tag_name        = "TEST"
    tag_description = "Test VM"
  }

  dev = {
    tag_name        = "DEV"
    tag_description = "Development VM"
  }
}