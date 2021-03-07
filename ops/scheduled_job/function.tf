# Creates a service account for jobs
# https://www.terraform.io/docs/providers/google/r/google_service_account.html
resource "google_service_account" "function_service_account" {
  account_id   = "${var.name}-function"
  display_name = "${var.name} service account"
  description  = "service account for executing the ${var.name} function"
}

# Waits for the service account
# https://www.terraform.io/docs/providers/google/r/google_service_account.html
# https://github.com/hashicorp/terraform/issues/17726#issuecomment-377357866
resource "null_resource" "function_service_account_delay" {
  provisioner "local-exec" {
    command = "sleep 30"
  }
  triggers = {
    "function_service_account" = google_service_account.function_service_account.unique_id
  }
}

# IAM permissions to invoke the function
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_cloud_function_iam
resource "google_cloudfunctions_function_iam_member" "function_invoker" {
  cloud_function = google_cloudfunctions_function.function.name
  role           = "roles/cloudfunctions.invoker"
  member         = "serviceAccount:${google_service_account.function_service_account.email}"
  depends_on     = [null_resource.function_service_account_delay]
}


# Creates the function from the archive
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function
resource "google_cloudfunctions_function" "function" {
  name                  = "${var.name}-function"
  description           = "cloud function '${var.name}'"
  runtime               = var.runtime
  available_memory_mb   = var.available_memory_mb
  source_archive_bucket = "${data.google_client_config.context.project}-functions"
  source_archive_object = google_storage_bucket_object.function_archive.name
  trigger_http          = true
  entry_point           = var.entry_point
  service_account_email = google_service_account.function_service_account.email
  depends_on            = [null_resource.function_service_account_delay]
}
