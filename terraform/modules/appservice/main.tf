resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location

  os_type  = "Linux"
  sku_name = "B1"
}

resource "azurerm_linux_web_app" "frontend" {
  name                = var.web_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    application_stack {
      docker_image_name   = "${var.frontend_image_name}:${var.frontend_image_tag}"
      docker_registry_url = "https://${var.acr_login_server}"
    }

    container_registry_use_managed_identity = true
  }

  app_settings = {
    WEBSITES_PORT = "3000"
    BACKEND_URL   = "http://98.70.222.216"
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      site_config[0].application_stack[0].docker_image_name
    ]
  }
}