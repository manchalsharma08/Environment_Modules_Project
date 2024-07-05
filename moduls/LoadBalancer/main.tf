resource "azurerm_public_ip" "PublicIPForLB" {
for_each = var.sharma
  name                = each.value.name_piplb
  location            = each.value.location
  resource_group_name = each.value.name_rg
  allocation_method   = "Static"
  sku                 = "Standard"
}

###    Azure Load Balancer
resource "azurerm_lb" "NginxLoadBalancer" {
    for_each = var.sharma
  name                = each.value.named_lb
  location            = each.value.location
  resource_group_name = each.value.name_rg
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.PublicIPForLB.ip
  }
}

####  Backend Address Pools


resource "azurerm_lb_backend_address_pool" "BackEndAddressPool" {
    
    loadbalancer_id = azurerm_lb.NginxLoadBalancer.id
  name            = "BackEndAddressPool"
}

###  Backend Address Pool Addresses

resource "azurerm_lb_backend_address_pool_address" "backendnginx01" {
    for_each = var.sharma
  name                    = "backendnginx01"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool.id
  virtual_network_id      = data.azurerm_virtual_network.lb-demo.id
  ip_address              = data.azurerm_virtual_machine.nginxvm01.private_ip_address
}

resource "azurerm_lb_backend_address_pool_address" "backendnginx02" {
  name                    = "backendnginx02"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool.id
  virtual_network_id      = data.azurerm_virtual_network.lb-demo.id
  ip_address              = data.azurerm_virtual_machine.nginxvm02.private_ip_address
}


####   Load Balancer Probe

resource "azurerm_lb_probe" "nginxprobe" {
  loadbalancer_id = azurerm_lb.NginxLoadBalancer.id
  name            = "http-port"
  port            = 80
}


###   Load Balancer Rules

resource "azurerm_lb_rule" "example" {
  loadbalancer_id                = azurerm_lb.NginxLoadBalancer.id
  name                           = "NginxRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.BackEndAddressPool.id]
  probe_id                       = azurerm_lb_probe.nginxprobe.id
}