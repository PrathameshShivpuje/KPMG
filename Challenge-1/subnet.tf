data "azurerm_virtual_network" "example" {
  name                = azurerm_virtual_network.vnet1.name
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "web_subnet" {
  name                 = var.web_subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_route_table" "web_subnet_route_table" {
  name                = "web-subnet-route-table"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  route {
    name           = "route-to-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }
}


resource "azurerm_subnet_route_table_association" "web_subnet_association" {
  subnet_id      = azurerm_subnet.web_subnet.id
  route_table_id = azurerm_route_table.web_subnet_route_table.id
}

resource "azurerm_subnet" "app_subnet" {
  name                 = var.app_subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "db_subnet" {
  name                 = var.db_subnet
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.3.0/24"]
}
