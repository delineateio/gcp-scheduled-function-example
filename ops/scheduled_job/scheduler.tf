# Creates the scheduler job for the requirement
# https://www.terraform.io/docs/providers/google/r/cloud_scheduler_job.html
resource "google_cloud_scheduler_job" "scheduler_job" {

  name             = "${var.name}-scheduler-job"
  description      = "Calls the '${google_cloudfunctions_function.function.name}' cloud function"
  time_zone        = var.time_zone
  schedule         = var.schedule
  attempt_deadline = var.attempt_deadline

  http_target {
    uri         = google_cloudfunctions_function.function.https_trigger_url
    http_method = var.http_method
    body        = base64encode("{\"name\":\"HTTP\"}")
    oidc_token {
      service_account_email = google_service_account.function_service_account.email
    }
  }

  depends_on = [null_resource.function_service_account_delay]
}
