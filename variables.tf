variable "lb_ip" {
  default = "load_blancer_ip"
}

variable "lb_frontend_ip_name" {
  default = "web_lb_frontend_ip"
}

variable "lb_backend_pool_name" {
  default = "web_backend"
}

variable "lb_rule_name" {
  default = "http"
}

variable "lb_probe_name" {
  default = "health_probe_ssh"
}


variable "lb_linux_ip_configuration_name" {
  default = "ip_conf_linux"
}

locals {
  common_tags = {
    Name           = "Automation Group Project – Assignment 2"
    GroupMembers   = "Manasa,Divyansh"
    ExpirationDate = "2021-08-31"
    Environment    = "Lab"
  }
}

variable "rg_name" {}

variable "location" {}

variable "linux_nic" {}

variable "windows_nic" {}

variable "subnet_id" {}

variable "lb_name" {}

variable "domain_name" {}

variable "lb_port" {}