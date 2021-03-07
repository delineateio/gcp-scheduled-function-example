# Enables Cloud Build
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "cloud_build" {
  service                    = "cloudbuild.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}


# Enables Cloud Functions
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "cloud_functions" {
  service                    = "cloudfunctions.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}


# Enables Cloud Scheduler
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_service
resource "google_project_service" "cloud_scheduler" {
  service                    = "cloudscheduler.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}
