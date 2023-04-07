module "extract_load" {
  source          = "../../modules/extract_load"
  bucket_location = "ASIA"
  bucket_class    = "STANDARD"
  project_id      = var.project_id
}