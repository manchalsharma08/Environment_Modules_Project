##### Subnet Data block for Feching subnet_id[for NIC] ####
data "azurerm_subnet" "datasnet" {
    for_each = var.sharma
  name                 = each.value.name_snet
  virtual_network_name = each.value.name_vnet
  resource_group_name  = each.value.name_rg
}

##### key-vault data block for Feching key_vault_id ####
data "azurerm_key_vault" "kvault" {
  for_each = var.sharma
  name                = each.value.name_kvault
  resource_group_name = each.value.name_rg
}

##### key_vault_secret data block for Feching VM username details ####
data "azurerm_key_vault_secret" "username" {
  for_each = var.sharma
  name = "username"
  key_vault_id = data.azurerm_key_vault.kvault[each.key].id
  }

##### key_vault_secret data block for Feching VM password details ####
  data "azurerm_key_vault_secret" "password" {
  for_each = var.sharma
  name = "password"
  key_vault_id = data.azurerm_key_vault.kvault[each.key].id
  }
