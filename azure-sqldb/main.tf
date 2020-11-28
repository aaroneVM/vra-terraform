provider "azurerm" {
    version = "~> 2.0"
    features {}
}

resource "azurerm_resource_group" "main" {
    name     = var.rgname
    location = "Australia East"
}

resource "azurerm_sql_server" "main" {
    name                         = var.SQLServerName
    resource_group_name          = "${azurerm_resource_group.main.name}"
    location                     = "${azurerm_resource_group.main.location}"
    version                      = "12.0"
    administrator_login          = var.SQLAdminAccount
    administrator_login_password = var.SQLAdminPassword
}

resource "azurerm_sql_firewall_rule" "main" {
  name                = "AlllowAzureServices"s
  resource_group_name = "${azurerm_resource_group.main.name}"
  server_name         = "${azurerm_sql_server.main.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_database" "main" {
  name                             = var.SQLInstanceName
  resource_group_name              = "${azurerm_resource_group.main.name}"
  location                         = "${azurerm_resource_group.main.location}"
  server_name                      = "${azurerm_sql_server.main.name}"
  edition                          = "Standard"
  requested_service_objective_name = "S0"
}