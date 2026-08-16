
variable subnetsandy {}



resource "azurerm_subnet" "sandy_subnet" {
    for_each = var.subnetsandy
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}