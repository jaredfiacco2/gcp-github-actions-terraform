#########################################################################
## Google Storage Definition 
#########################################################################
# Create Infra Bucket
resource "google_storage_bucket" "bucket" {
  name     = var.infra_bucket
  location = var.region
}

#########################################################################
## Google Function Definition 
#########################################################################
# Store Code As Infra Bucket Object
resource "google_storage_bucket_object" "archive" {
  name   = "my-gcp-python-file.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./functions/my-repos-python-file.zip"
}
# Google Function Based From Infra Bucket Object
resource "google_cloudfunctions_function" "function" {
  name        = "my-functions-name"
  description = "my functions description"
  runtime     = "python310"
  entry_point = "hello_gcs"

  available_memory_mb   = 128
  max_instances = 1
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  event_trigger         {
    event_type  = "google.storage.object.finalize"
    resource    = var.resume_bucket
  }  
  environment_variables = {
    key         = "123" 
    project_id  = var.project_id
    region      = var.region
  }      
}
# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}