variable pip{}

resource "azurerm_public_ip" "sandypip" {
    for_each = var.pip
  name                = each.value.pipname
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
}
