data "azurerm_public_ip" "data_pip_sandy" {
    for_each = var.vms
  name                = each.value.pipname
  resource_group_name = each.value.resource_group_name
}
data "azurerm_subnet" "data_subnet_sandy" {
    for_each = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}