vsphere_server   = "vcsa-01.localdomain"
vsphere_user     = "administrator@vsphere.local"
vsphere_password = "VMware1!"

custom_attributes = {
  builtby = {
    attribute_name = "Built By"
    attribute_type = "VirtualMachine"
  }

  repo = {
    attribute_name = "Repo"
    attribute_type = "VirtualMachine"
  }

  costcenter = {
    attribute_name = "Cost Center"
    attribute_type = "VirtualMachine"
  }
}