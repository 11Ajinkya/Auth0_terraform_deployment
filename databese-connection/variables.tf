provider "auth0" {
  domain        = var.auth0_domain
  debug         = false
}

terraform {
  required_version = ">= 1.7.0"

  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 1.1.2"
    }
  }
}

variable "auth0_domain" {
  default     = "https://us.auth0.com"
  description = "Auth0 domain"
}

variable "auth0_client_id" {
  default     = ""  
  description = "Auth0 client ID"
}

variable "auth0_client_secret" {
  default     = ""  
  description = "Auth0 client secret"
}

