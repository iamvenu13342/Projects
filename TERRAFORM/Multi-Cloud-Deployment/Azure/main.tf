resource "azurerm_resource_group" "main" {
  name     = "example-resources"
  location = "West US"
}

resource "azurerm_virtual_network" "main" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}
