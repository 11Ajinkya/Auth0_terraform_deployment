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
}


/// This is an example of a Google OAuth2 connection. ///
resource "auth0_connection" "google_oauth2" {
  name     = "Google-OAuth2-Connection-demo"
  strategy = "google-oauth2"

  options {
    client_id                = "<client-id>"
    client_secret            = "<client-secret>"
    allowed_audiences        = ["example.com", "api.example.com"]
    # scopes                   = ["email", "profile", "gmail", "youtube"] # you can edit scopes for here #
    set_user_root_attributes = "on_each_login"
    non_persistent_attrs     = ["ethnicity", "gender"]
  }
}


/// This is an example of an Apple connection. ///
resource "auth0_connection" "apple" {
  name     = "Apple-Connection-demo"
  strategy = "apple"

  options {
    client_id                = "<client-id>"
    client_secret            = "-----BEGIN PRIVATE KEY-----\nMIHBAgEAMA0GCSqGSIb3DQEBAQUABIGsMIGpAgEAA\n-----END PRIVATE KEY-----"
    team_id                  = "<team-id>"
    key_id                   = "<key-id>"
    # scopes                   = ["email", "name"] # you can edit scopes for here #
    set_user_root_attributes = "on_first_login"
    non_persistent_attrs     = ["ethnicity", "gender"]
  }
}


/// This is an example of a WindowsLive connection. ///
resource "auth0_connection" "windowslive" {
  name     = "Windowslive-Connection-demo"
  strategy = "windowslive"

  options {
    client_id                = "<client-id>"
    client_secret            = "<client-secret>"
    strategy_version         = 2 
    scopes                   = ["signin", "graph_user"]
    set_user_root_attributes = "on_first_login"
    non_persistent_attrs     = ["ethnicity", "gender"]
  }
}