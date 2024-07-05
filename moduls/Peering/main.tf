data "azurerm_virtual_network" "peering" {
  for_each = var.sharma
  name                = each.value.name_vnet
  resource_group_name = each.value.name_rg
}
data "azurerm_virtual_network" "peering1" {
  for_each =  var.sharma
  name                = each.value.name_vnet1
  resource_group_name = each.value.name_rg
}
resource "azurerm_virtual_network_peering" "perringforward" {
    for_each = var.sharma
  name                      = each.value.name_peeringforward
  resource_group_name       = each.value.name_rg
  virtual_network_name      = each.value.name_vnet
  remote_virtual_network_id = data.azurerm_virtual_network.peering1[each.key].id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}



resource "azurerm_virtual_network_peering" "perringbackward" {
    for_each = var.sharma
  name                      = each.value.name_peeringbackward
  resource_group_name       = each.value.name_rg
  virtual_network_name      = each.value.name_vnet1
  remote_virtual_network_id = data.azurerm_virtual_network.peering[each.key].id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}