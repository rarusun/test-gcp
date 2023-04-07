resource google_storage_bucket j_quants_data {
    name = "${var.project_id}-j-quants-data-${var.env}"
    location = "ASIA"
}