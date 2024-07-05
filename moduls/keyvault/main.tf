data "azurerm_client_config" "current" {}



resource "azurerm_key_vault" "kvault" {
    for_each = var.sharma
  name                        = each.value.name_kvault
  location                    = each.value.location
  resource_group_name         = each.value.name_rg
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
        "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}


#######          Random Password        ########

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}


############# User Name  ################
resource "azurerm_key_vault_secret" "secretuser" {
  for_each = var.sharma
  name         = "username"
  value        = each.value.value_username
  key_vault_id = azurerm_key_vault.kvault[each.key].id
}

############# Password  ################
resource "azurerm_key_vault_secret" "secretpassword" {
  for_each = var.sharma
  name         = "password"
  value        = random_password.password.result
  key_vault_id = azurerm_key_vault.kvault[each.key].id
}