resource "azurerm_public_ip" "lb_ip" {
  name                = "publicIPForLB"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  domain_name_label   = var.domain_name
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = var.lb_frontend_ip_name
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  name            = var.lb_backend_pool_name
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "linux_nic_backend_association" {
  count                   = length(var.linux_nic)
  ip_configuration_name   = element(var.linux_nic[*].ip_configuration[0].name, count.index)
  network_interface_id    = element(var.linux_nic[*].id, count.index)
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = var.rg_name
  name                = var.lb_probe_name
  loadbalancer_id     = azurerm_lb.lb.id
  port                = var.lb_port
}

resource "azurerm_lb_rule" "lb_rule" {
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = var.lb_rule_name
  protocol                       = "Tcp"
  frontend_port                  = var.lb_port
  backend_port                   = var.lb_port
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
  frontend_ip_configuration_name = azurerm_lb.lb.frontend_ip_configuration[0].name
  probe_id = azurerm_lb_probe.lb_probe.id
}