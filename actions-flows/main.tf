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

# resource "auth0_action" "my_action" {
#   name     = format("Test Action")          ///Add action///
#   runtime  = "node18"
#   deploy   = true
#   code     = <<-EOT
#   /**
#    * Handler that will be called during the execution of a PostLogin flow.
#    *
#    * @param {Event} event - Details about the user and the context in which they are logging in.
#    * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
#    */
#   exports.onExecutePostLogin = async (event, api) => {
#     console.log(event);
#   };
#   EOT

#   supported_triggers {
#     id      = "post-login"
#     version = "v3"
#   }

#   dependencies {
#     name    = "lodash"
#     version = "latest"
#   }

#   dependencies {
#     name    = "request"
#     version = "latest"
#   }

#   secrets {
#     name  = "FOO"
#     value = "Foo"
#   }

#   secrets {
#     name  = "BAR"
#     value = "Bar"
#   }
# }

# resource "auth0_action" "redirect_signup" {
#   name     = format("Redirect Signup")                          ///Add action///
#   runtime  = "node18"
#   deploy   = true
#   code     = <<-EOT
#   /**
#    * Handler that will be called during the execution of a Login flow.
#    *
#    * @param {Event} event - Details about the user and the context in which they are logging in.
#    * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
#    */
#   exports.onExecutePostLogin = async (event, api) => {
#     if (event.transaction.protocol !== 'redirect-callback') {
#       api.redirect.sendUserTo("https://example.com/signup");
#     }
#   };
#   EOT

#   supported_triggers {
#     id      = "post-login"
#     version = "v3"
#   }
# }

# resource "auth0_action" "add_roles" {
#   name     = format("Add Roles")                                     ///Add action///
#   runtime  = "node18"
#   deploy   = true
#   code     = <<-EOT
#   /**
#    * Handler that will be called during the execution of a Login flow.
#    *
#    * @param {Event} event - Details about the user and the context in which they are logging in.
#    * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
#    */
#   exports.onExecutePostLogin = async (event, api) => {
#     const assignedRoles = ['user']; // Assign default role
#     api.idToken.setCustomClaim('https://example.com/roles', assignedRoles);
#     api.accessToken.setCustomClaim('https://example.com/roles', assignedRoles);
#   };
#   EOT

#   supported_triggers {
#     id      = "post-login"
#     version = "v3"
#   }
# }

# resource "auth0_action" "add_data_token" {
#   name     = format("Add Data Token")                                      ///Add action/// 
#   runtime  = "node18"
#   deploy   = true
#   code     = <<-EOT
#   /**
#    * Handler that will be called during the execution of a Login flow.
#    *
#    * @param {Event} event - Details about the user and the context in which they are logging in.
#    * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
#    */
#   exports.onExecutePostLogin = async (event, api) => {
#     api.idToken.setCustomClaim('https://example.com/custom_claim', 'custom_value');
#     api.accessToken.setCustomClaim('https://example.com/custom_claim', 'custom_value');
#   };
#   EOT

#   supported_triggers {
#     id      = "post-login"
#     version = "v3"
#   }
# }

////-----------------------------------------------------------------------------------------------------------------------------//

resource "auth0_action" "my_action" {
  name     = "Test Action"
  runtime  = "node18"
  deploy   = true
  code     = <<-EOT
  /**
   * Handler that will be called during the execution of a PostLogin flow.
   *
   * @param {Event} event - Details about the user and the context in which they are logging in.
   * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
   */
  exports.onExecutePostLogin = async (event, api) => {
    console.log(event);
  };
  EOT

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }

  dependencies {
    name    = "lodash"
    version = "latest"
  }

  dependencies {
    name    = "request"
    version = "latest"
  }

  secrets {
    name  = "FOO"
    value = "Foo"
  }

  secrets {
    name  = "BAR"
    value = "Bar"
  }
}

resource "auth0_action" "redirect_signup" {
  name     = "Redirect Signup"
  runtime  = "node18"
  deploy   = true
  code     = <<-EOT
  /**
   * Handler that will be called during the execution of a PostLogin flow.
   *
   * @param {Event} event - Details about the user and the context in which they are logging in.
   * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
   */
  exports.onExecutePostLogin = async (event, api) => {
    if (!event.user.app_metadata.roleId || event.user.app_metadata.roleId) {
      const token = api.redirect.encodeToken({
        expiresInSeconds: 300,
        secret: event.secrets.MY_REDIRECT_SECRET,
        payload: {
          email: event.user.email
        }
      });
      api.redirect.sendUserTo(`${event.request.query.redirect_uri}/personal-info`, {
        query: { session_token: token }
      }); 
    }
  };

  exports.onContinuePostLogin = async (event, api) => {
    // Continue post login logic here
  };
  EOT

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }
}

resource "auth0_action" "add_roles" {
  name     = "Add Roles"
  runtime  = "node18"
  deploy   = true
  code     = <<-EOT
  /**
   * Handler that will be called during the execution of a PostLogin flow.
   *
   * @param {Event} event - Details about the user and the context in which they are logging in.
   * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
   */
  const LOAN_OFFICER_ROLE_ID = "rol_Vp7wm1UhdkmJXMm3";
  const CONSUMER_ROLE_ID = "rol_H0sE4gx0Hk6dQKAO";
  const MIRA_UAT_CLIENT_ID = "tdU3jHzxVMccYflANOUmkrsc9e9D13u3";

  exports.onExecutePostLogin = async (event, api) => {
    if (event.authorization && event.authorization.roles) {
      const ManagementClient = require('auth0').ManagementClient;

      var management = new ManagementClient({
        domain: event.secrets.domain,
        clientId: event.secrets.clientId,
        clientSecret: event.secrets.clientSecret,
      });
      const axios = require('axios');

      try {
        const userId = event.user.user_id;
        const params = { id: userId };
        const clientId = event.request.query.client_id;
        const urlDomain = clientId === MIRA_UAT_CLIENT_ID ? "https://miralabs.ai" : "https://miralabs.ai/";
        const url = `$${urlDomain}/user/is_loan_officer/$${userId.slice(6)}`;
        const options = {
          headers: {
            'Content-Type': 'application/json'
          }
        };
        console.log("IS LOAN OFFICER ===> ", url);
        const is_loan_officer = await axios.get(url, options);
        console.log(is_loan_officer.data);
        let data;
        let rolesToRemove;
        if (clientId === MIRA_UAT_CLIENT_ID) {
          if (is_loan_officer.data === true) {
            data = { "roles": [LOAN_OFFICER_ROLE_ID] };
          } else {
            data = { "roles": [CONSUMER_ROLE_ID] };
          }
        } else {
          if (event.user.app_metadata.roleId === 1) {
            data = { "roles": [LOAN_OFFICER_ROLE_ID] };
            rolesToRemove = { "roles": [CONSUMER_ROLE_ID] };
          } else {
            data = { "roles": [CONSUMER_ROLE_ID] };
            rolesToRemove = { "roles": [LOAN_OFFICER_ROLE_ID] };
          }
          await management.users.deleteRoles(params, rolesToRemove);
        }
        await management.users.assignRoles(params, data);
      } catch (e) {
        console.log("error", e);
      }
    }
  };

  /**
   * Handler that will be invoked when this action is resuming after an external redirect. If your
   * onExecutePostLogin function does not perform a redirect, this function can be safely ignored.
   *
   * @param {Event} event - Details about the user and the context in which they are logging in.
   * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
   */
  // exports.onContinuePostLogin = async (event, api) => {
  // };
  EOT

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }
}

resource "auth0_action" "add_data_token" {
  name     = "Add Data Token"
  runtime  = "node18"
  deploy   = true
  code     = <<-EOT
  /**
   * Handler that will be called during the execution of a PostLogin flow.
   *
   * @param {Event} event - Details about the user and the context in which they are logging in.
   * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
   */
  const MIRA_UAT_CLIENT_ID = "tdU3jHzxVMccYflANOUmkrsc9e9D13u3";
  const ALWAYS_ONBOARDING_USER_ID_DEV = "1";
  const ALWAYS_ONBOARDING_USER_ID_UAT = "4";

  exports.onExecutePostLogin = async (event, api) => {
    try {
      const axios = require('axios');
      console.log(event.user.app_metadata);
      const metaData = event.user.app_metadata;
      const provider = event.user.user_id.split("|")[0];
      const userId = event.user.user_id.split("|")[1];
      const firstName = metaData?.firstName || event.user?.user_metadata?.firstName || event.user?.given_name || event.user?.name || "Consumer";
      const lastName = metaData?.lastName || event.user?.user_metadata?.lastName || event.user?.family_name || "";
      const phoneNumber = metaData?.phoneNumber || event.user?.user_metadata?.phoneNumber || event.user?.phone_number || "";
      const emailVerified = event.user?.is_Verified === "1" ? 1 : 0;
      const clientId = event.request.query.client_id;
      const urlDomain = clientId === MIRA_UAT_CLIENT_ID ? "https://miralabs.ai" : "https://dev-api.miralabs.ai";
      const alwaysOnboardingUserId = clientId === MIRA_UAT_CLIENT_ID ? ALWAYS_ONBOARDING_USER_ID_UAT : ALWAYS_ONBOARDING_USER_ID_DEV;
      const roleId = metaData?.roleId;
      if (userId === alwaysOnboardingUserId) {
        const url = `${urlDomain}/user/application/${userId}`;
        const options = {
          headers: {
            'Content-Type': 'application/json'
          }
        };
        await axios.delete(url, options);
      }

      // Call API to check if user is logging in for the first time
      const url = `${urlDomain}/user/is_first_time_user`;
      const options = {
        headers: {
          'Content-Type': 'application/json'
        }
      };
      const data = {
        "user_id": userId,
        "source": provider,
        "email": event.user.email,
        "first_name": firstName,
        "last_name": lastName
      };

      const response = await axios.post(url, data, options);

      // Add claims to token
      api.accessToken.setCustomClaim("user_id", response.data.data.user_id);
      api.accessToken.setCustomClaim("user_email", event.user.email);
      api.accessToken.setCustomClaim("first_name", firstName);
      api.accessToken.setCustomClaim("last_name", lastName);
      api.accessToken.setCustomClaim("user_phone_number", phoneNumber);
      api.accessToken.setCustomClaim("email_verified", emailVerified);
      api.accessToken.setCustomClaim("roleId", roleId);

      if (response.data && response.data.data) {
        api.accessToken.setCustomClaim("new_user", response.data.data.new_user);
        api.accessToken.setCustomClaim("user_profile_exists", response.data.data.user_profile_exists);
        api.accessToken.setCustomClaim("pending_application_id", response.data.data.pending_application_id);
      }
    } catch (e) {
      console.log("Error ===> ", e);
    }
  };

  /**
   * Handler that will be invoked when this action is resuming after an external redirect. If your
   * onExecutePostLogin function does not perform a redirect, this function can be safely ignored.
   *
   * @param {Event} event - Details about the user and the context in which they are logging in.
   * @param {PostLoginAPI} api - Interface whose methods can be used to change the behavior of the login.
   */
  // exports.onContinuePostLogin = async (event, api) => {
  // };
  EOT

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }
}

resource "auth0_action_sequence" "login_flow" {
  name = "Login Flow"

  triggers {
    post_login {
      actions = [
        auth0_action.my_action.id,
        auth0_action.redirect_signup.id,
        auth0_action.add_roles.id,
        auth0_action.add_data_token.id,
      ]
    }
  }
}
