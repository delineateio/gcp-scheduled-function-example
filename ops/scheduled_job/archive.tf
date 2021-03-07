# Create the archive project
# https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/archive_file
data "archive_file" "function_archive" {
  type        = "zip"
  output_path = "/tmp/${var.name}-function.zip"
  source_dir  = var.function_source
}

# Archive file containing the function
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object
resource "google_storage_bucket_object" "function_archive" {
  name   = "${var.name}-function.zip"
  bucket = "${data.google_client_config.context.project}-functions"
  source = "/tmp/${var.name}-function.zip"
}
