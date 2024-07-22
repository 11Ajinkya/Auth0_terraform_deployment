terraform {
  required_version = ">= 1.7.0"
  
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "~> 1.1.2"
    }
  }
}

/// This is an code of an Auth0 connection to DB. ///
resource "auth0_connection" "my_connection" {
  name                 = "Example-DB-Connection"
  is_domain_connection = true
  strategy             = "auth0"
  metadata = {
    key1 = "key1"
    key2 = "key2"
  }

  options {
    password_policy                = "excellent"
    brute_force_protection         = true
    enabled_database_customization = true
    import_mode                    = false
    requires_username              = false
    disable_signup                 = false
    custom_scripts = {
      login = file("${path.module}/scripts/login.js")
      create = file("${path.module}/scripts/create.js")
      verify = file("${path.module}/scripts/verify.js")
      change_password = file("${path.module}/scripts/change_password.js")
      get_user = file("${path.module}/scripts/get_user.js")
      delete = file("${path.module}/scripts/delete.js")
    }
    configuration = {
      DATABASE_URI = "DATABASE_URI"
      Example_URI  = "Exaple_URI"
    }
    upstream_params = jsonencode({
      "screen_name" : {
        "alias" : "login_hint"
      }
    })

    password_history {
      enable = true
      size   = 3
    }

    password_no_personal_info {
      enable = true
    }

    password_dictionary {
      enable     = true
      dictionary = ["password", "admin", "1234"]
    }

    password_complexity_options {
      min_length = 12
    }

    validation {
      username {
        min = 1
        max = 15
      }
    }

    mfa {
      active                 = true
      return_enroll_settings = true
    }
  }
}