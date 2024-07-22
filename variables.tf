variable "auth0_domain" {
  description = "Auth0 domain"
  type        = string
}

variable "auth0_client_id" {
  description = "Auth0 client ID"
  type        = string
  sensitive   = true
}

variable "auth0_client_secret" {
  description = "Auth0 client secret"
  type        = string
  sensitive   = true
}

### API, Roles and Permissions ###
variable "api_name" {
  description = "Auth0 domain"
  type        = string
}

variable "identifier" {
  description = "Auth0 domain"
  type        = string
}

variable "signing_alg" {
  description = "Auth0 domain"
  type        = string
}

variable "token_lifetime" {
  description = "Auth0 domain"
  type        = string
}

variable "permissions_1_name" {
  description = "Auth0 domain"
  type        = string
}

variable "permissions_2_name" {
  description = "Auth0 domain"
  type        = string
}

variable "permissions_3_name" {
  description = "Auth0 domain"
  type        = string
}

variable "permissions_1_description" {
  description = "Auth0 domain"
  type        = string
}

variable "permissions_2_description" {
  description = "Auth0 domain"
  type        = string
}

variable "permissions_3_description" {
  description = "Auth0 domain"
  type        = string
}

### Application ###
variable "application_name" {
  type = string
}

variable "application_description" {
  type = string
}

variable "app_type" {
  type = string
}