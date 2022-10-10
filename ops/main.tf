terraform {
  required_version = ">=0.14.3"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.39.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

# Enables access to provider details
# https://www.terraform.io/docs/providers/google/d/datasource_client_config.html
provider "google" {}
data "google_client_config" "context" {}


# The bucket containing the functions
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket
resource "google_storage_bucket" "function_storage" {
  name          = "${data.google_client_config.context.project}-functions"
  force_destroy = true
}


# creates the hello job
# ./job
module "hello_job" {
  source          = "./scheduled_job"
  name            = "hello"
  entry_point     = "helloWorld"
  function_source = "../dev/hello"
  schedule        = "0 */3 * * *"
}

# Additional parameters
# -----------------------------------------------------
# runtime             = "nodejs10"
# attempt_deadline    = "360s"
# http_method         = "POST"
# available_memory_mb = 128
# time_zone           = "Europe/London"
