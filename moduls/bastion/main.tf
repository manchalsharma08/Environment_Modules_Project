data "azurerm_subnet" "datasnet" {
    for_each = var.sharma
  name                 = each.value.name_snet
  virtual_network_name = each.value.name_vnet
  resource_group_name  = each.value.name_rg
}
resource "azurerm_public_ip" "pip" {
    for_each = var.sharma

  name                = each.value.name_pip
  location            = each.value.location
  resource_group_name = each.value.name_rg
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
    for_each = var.sharma
  name                = each.value.name_bastion
  location            = each.value.location
  resource_group_name = each.value.name_rg

  ip_configuration {
    name                 =each.value.name_bastion
    subnet_id            = data.azurerm_subnet.datasnet[each.key].id
       public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
}