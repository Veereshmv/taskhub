output "sql_server_name" {
  value = azurerm_mssql_server.sql_server.name
}

output "database_name" {
  value = azurerm_mssql_database.database.name
}

output "server_fqdn" {
  value = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}