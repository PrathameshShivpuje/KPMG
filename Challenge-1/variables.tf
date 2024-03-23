variable "resource_group_name" {
  description = "Resource Group name"
}

variable "location" {
  description = "Location"
}

variable "vnet1" {
  description = "Virtual network name"
}

variable "web_subnet" {
  description = "Web Subnet name"
}

variable "app_subnet" {
  description = "App Subnet name"
}

variable "db_subnet" {
  description = "DataBase Subnet name"
}

variable "webvm" {
  description = "Web Virtual Machine name"
}

variable "web_nsg" {
  description = "Web Network Security Group"
}

variable "appvm" {
  description = "App virtual Machine name"
}

variable "app_nsg" {
  description = "App Network Security Group"
}

variable "db_nsg" {
  description = "MySQL Network Security Group"
}

variable "lb_public_ip" {
  description = "LB public ip name"
}

variable "publiclb" {
  description = "Public loadbalancer name"
}

variable "public_lb_nsg" {
  description = "Public LB Network Security Group"
}

variable "internal_lb" {
  description = "Internal LoadBalancer Name"
}

variable "internal_backend_pool" {
  description = "Internal BackEnd Pool"
}

variable "private_lb_nsg" {
  description = "Private LoadBalancer Network Security Group"
}

variable "app_username" {
  description = "App vm username"

}

variable "app_password" {
  description = "App vm password"
  sensitive   = true

}

variable "web_username" {
  description = "App vm username"
}

variable "web_password" {
  description = "App vm password"
  sensitive   = true

}

variable "pgserver" {
  description = "PostGress server name"
}

variable "pgdatabase" {
  description = "Postgress database name"
}
variable "administrator_login" {
  description = "Login Id"
}

variable "administrator_login_password" {
  description = "Login password"
  sensitive   = true
}