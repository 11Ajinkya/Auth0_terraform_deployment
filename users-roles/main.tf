# Create a role for admin users
resource "auth0_role" "admin" {
  name        = "ROLE_ADMIN"
  description = "Administrator"
}

# Create a role for regular users
resource "auth0_role" "user" {
  name        = "ROLE_USER"
  description = "User"
}

# Create an admin user
resource "auth0_user" "admin_user" {
  connection_name = "Username-Password-Authentication"
#   username        = "unique_username"  
  name            = "Jane Doe"
  email           = "jane@test.com"
  email_verified  = true
  password        = var.default_password
#    picture         = "https://www.example.com/a-valid-picture-url.jpg"
}

# Assign roles to the admin user
resource "auth0_user_roles" "admin_user_roles" {
  user_id = auth0_user.admin_user.id
  roles   = [auth0_role.admin.id, auth0_role.user.id]
}

# Create a regular user
resource "auth0_user" "regular_user" {
  connection_name = "Username-Password-Authentication"
  name            = "John Doe"
  email           = "john@test.com"
  email_verified  = false
  password        = var.default_password
}

# Assign roles to the regular user
resource "auth0_user_roles" "regular_user_roles" {
  user_id = auth0_user.regular_user.id
  roles   = [auth0_role.user.id]
}