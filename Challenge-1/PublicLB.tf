resource "azurerm_public_ip" "lb_public_ip" {
  name                = var.lb_public_ip
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "publiclb" {
  name                = var.publiclb
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location


  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

}

resource "azurerm_lb_backend_address_pool" "pool" {
  name            = "BackEndAddressPool"
  loadbalancer_id = azurerm_lb.publiclb.id
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id  = azurerm_lb.publiclb.id
  name             = "http-probe"
  protocol         = "Http"
  port             = 80
  request_path     = "/"
  number_of_probes = 2
}

resource "azurerm_lb_rule" "rule" {
  loadbalancer_id                = azurerm_lb.publiclb.id
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.probe.id
}

resource "azurerm_network_security_group" "public_lb_nsg" {
  name                = var.public_lb_nsg
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}


resource "azurerm_network_security_rule" "public_lb_inbound_http" {
  name                        = "Allow_HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.public_lb_nsg.name
}

resource "azurerm_network_security_rule" "public_lb_inbound_https" {
  name                        = "Allow_HTTPS"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.public_lb_nsg.name
}
