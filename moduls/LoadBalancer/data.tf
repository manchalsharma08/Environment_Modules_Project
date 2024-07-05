## Data Block for Vnet
data "azurerm_virtual_network" "example" {
  name                = "production"
  resource_group_name = "networking"
}


#### Data Block for VM 
data "azurerm_virtual_machine" "vm" {
  name                = each.value.name_vm
  resource_group_name = "networking"
}