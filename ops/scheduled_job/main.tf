# Enables access to provider details
# https://www.terraform.io/docs/providers/google/d/datasource_client_config.html
data "google_client_config" "context" {}


# Loads into locals for less typing!
# https://www.terraform.io/docs/configuration/locals.html
locals {
  project = data.google_client_config.context.project
}
