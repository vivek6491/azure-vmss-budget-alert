provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_consumption_budget_resource_group" "example" {
  name                = "budget-alert-vmss"
  resource_group_id   = azurerm_resource_group.example.id
  amount              = 100  # Budget limit in your currency
  time_grain          = "Monthly"
  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  notification {
    enabled        = true
    operator       = "GreaterThan"
    threshold      = 80  # percentage
    contact_emails = [var.alert_email]
  }
}
