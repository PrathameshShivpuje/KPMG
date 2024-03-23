resource "azurerm_lb" "internal_lb" {
  name                = var.internal_lb
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  frontend_ip_configuration {
    name                          = "InternalIPAddress"
    subnet_id                     = azurerm_subnet.app_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "internal_backend_pool" {
  name            = var.internal_backend_pool
  loadbalancer_id = azurerm_lb.internal_lb.id
}

resource "azurerm_lb_rule" "internal_lb_rule" {
  name                           = "AppTierRule"
  loadbalancer_id                = azurerm_lb.internal_lb.id
  frontend_ip_configuration_name = "InternalIPAddress"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 8080
}

resource "azurerm_lb_probe" "internal_probe" {
  name                = "InternalHealthProbe"
  loadbalancer_id     = azurerm_lb.internal_lb.id
  protocol            = "Http"
  port                = 80
  interval_in_seconds = 15
  request_path        = "/"
  number_of_probes    = 2
}

resource "azurerm_network_security_group" "private_lb_nsg" {
  name                = var.private_lb_nsg
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_network_security_rule" "private_lb_inbound_http" {
  name                        = "Allow_HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.private_lb_nsg.name
}

resource "azurerm_network_security_rule" "private_lb_inbound_https" {
  name                        = "Allow_HTTPS"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.private_lb_nsg.name
}


resource "azurerm_subnet_network_security_group_association" "private_lb_nsg_association" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.private_lb_nsg.id
}