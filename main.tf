terraform {
  required_version = ">= 1.7.0"
  
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 1.1.2"
    }
  }
}

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
  debug         = false
}

module "api_roles_permissions" {
  source                    = "./api-persmissons-roles"
  api_name                  = var.api_name
  identifier                = var.identifier
  signing_alg               = var.signing_alg
  token_lifetime            = var.token_lifetime
  permissions_1_name        = var.permissions_1_name
  permissions_1_description = var.permissions_1_description
  permissions_2_name        = var.permissions_2_name
  permissions_2_description = var.permissions_2_description
  permissions_3_name        = var.permissions_3_name
  permissions_3_description = var.permissions_3_description
}

module "application" {
  source = "./application"
  application_name = var.application_name
  application_description = var.application_description
  app_type = var.app_type
}