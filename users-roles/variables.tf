variable "default_password" {
  default     = "Admin_@12345"
  description = "Default password for all users"
  sensitive   = true
}

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
  default     = "https://dev-hmfv3bt5bcxcuozz.us.auth0.com"
  description = "Auth0 domain"
}

variable "auth0_client_id" {
  default     = "KXANEBl888BewpB47aNPShSuB5GkEQu6"  
  description = "Auth0 client ID"
}

variable "auth0_client_secret" {
  default     = "M0S7nm8WK_MBaZmBP_aV3jb1VDxdCcfhFSgpvDs8Bi-g6sCpQr7PEFlqMf3Kyb7p"  
  description = "Auth0 client secret"
}
