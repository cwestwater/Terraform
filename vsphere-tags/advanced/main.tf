resource "vsphere_tag_category" "environment" {
  name        = "Environment"
  description = "What environment is the VM part of"
  cardinality = "SINGLE"

  associable_types = [
    "VirtualMachine",
  ]
}

resource "vsphere_tag" "vm_tags" {
  for_each    = var.tags
  name        = each.value.tag_name
  category_id = vsphere_tag_category.environment.id
  description = each.value.tag_description
}
