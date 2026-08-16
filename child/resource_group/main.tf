variable sandyrg {}


resource "azurerm_resource_group" "sandy_rg" {
for_each = var.sandyrg
  name     = each.value.name
  location = each.value.location
}
