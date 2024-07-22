terraform {
  required_version = ">= 1.7.0"
  
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 1.1.2"
    }
  }
}

resource "auth0_client" "my_client" {
  name                   = var.application_name
  description            = var.application_description
  app_type               = var.app_type
  custom_login_page_on   = true
  is_first_party         = true
  oidc_conformant        = true  
  callbacks              = ["http://localhost:8080/callback"]
  allowed_origins        = ["https://example.com"]
  allowed_logout_urls    = ["http://localhost:8080"]
  web_origins            = ["https://example.com"]
  grant_types            = [
    "authorization_code",
    "http://auth0.com/oauth/grant-type/password-realm",
    "implicit",
    "password",
    "refresh_token"
  ]
  client_metadata        = {
    foo = "zoo"
  }

  jwt_configuration {
    lifetime_in_seconds = 36000
    secret_encoded     = true
    alg                 = "RS256"
    scopes              = {
      foo = "bar"
    }
  }

  refresh_token {
    leeway               = 0
    token_lifetime       = 2592000
    rotation_type        = "rotating"
    expiration_type      = "expiring"
  }

  # Optional: Specify token_endpoint_auth_method if it's applicable in your Auth0 configuration
  # Removed the line as client authentication is not configured in this option

  mobile {
    ios {
      team_id               = "9JA89QQLNQ"
      app_bundle_identifier = "com.my.bundle.id"
    }
  }

  addons {
    samlp {
      audience             = "https://example.com/saml"
      issuer               = "https://example.com"
      mappings             = {
        email = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
        name  = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
      }
      create_upn_claim      = false
      passthrough_claims_with_no_mapping = false
      map_unknown_claims_as_is = false
      map_identities        = false
      name_identifier_format = "urn:oasis:names:tc:SAML:2.0:nameid-format:persistent"
      name_identifier_probes = [
        "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
      ]
      signing_cert = "-----BEGIN PUBLIC KEY-----\nMIGf...bpP/t3\n+JGNGIRMj1hF1rnb6QIDAQAB\n-----END PUBLIC KEY-----\n"
    }
  }
}

# Configuring client_secret_post is removed as client authentication is not used in this option
# resource "auth0_client_credentials" "client_creds" {
#   client_id = auth0_client.my_client.id
#   authentication_method = "client_secret_basic"
# }

/// ----------------------------------------------------------------------------------------------------------------------------------- ///

# # Create a new Auth0 application for OIDC authentication
# resource "auth0_client" "oidc_client" {
#   name                = "MydemoApp"
#   description         = "My demo App Client Created Through Terraform"
#   app_type            = "regular_web"
#   callbacks           = ["http://localhost:8080/callback"]
#   allowed_logout_urls = ["http://localhost:8080"]
#   oidc_conformant     = true

#   jwt_configuration {
#     alg = "RS256"
#   }
# }

# # Configuring client_secret_post as an authentication method.
# resource "auth0_client_credentials" "oidc_client_creds" {
#   client_id = auth0_client.oidc_client.id
#   authentication_method = "client_secret_post"
# }