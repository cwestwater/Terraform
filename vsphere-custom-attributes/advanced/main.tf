resource "vsphere_custom_attribute" "vm_attributes" {
  for_each            = var.custom_attributes
  name                = each.value.attribute_name
  managed_object_type = each.value.attribute_type
}