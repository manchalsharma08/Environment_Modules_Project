##### Network interface card Block #########
resource "azurerm_network_interface" "nic" {
    for_each = var.sharma
  name                = each.value.name_nic
  location            = each.value.location
  resource_group_name = each.value.name_rg

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.datasnet[each.key].id
    
        private_ip_address_allocation = "Dynamic"
  }
}

##### Linux VM Block #########
resource "azurerm_linux_virtual_machine" "vm" {
    for_each = var.sharma
  name                = each.value.name_vm
  resource_group_name = each.value.name_rg
  location            = each.value.location
  size                = each.value.size
  admin_username      = data.azurerm_key_vault_secret.username[each.key].value
  admin_password = data.azurerm_key_vault_secret.password[each.key].value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}