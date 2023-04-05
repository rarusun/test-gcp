resource "google_service_account" "github_actions" {
  account_id   = var.service_account_name
  display_name = var.service_account_name
  description  = "service account for github actions"
}

resource "google_iam_workload_identity_pool" "github_actions" {
  provider                  = google-beta
  project                   = var.project_id
  workload_identity_pool_id = var.pool_id
  display_name              = var.pool_id
  description               = "workload identity pool for github actions"
}

# https://cloud.google.com/iam/docs/configuring-workload-identity-federation?hl=ja#oidc
# プロバイダは、Sevurity Token Serviceで外部IDプロバイダの発行した認証情報とアクセストークンを交換し、
# トークンと、プールに紐づいたサービスアカウントの権限を使って、GCPのリソースにアクセスする
resource "google_iam_workload_identity_pool_provider" "github_actions" {
  provider                           = google-beta
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_actions.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  # GCPのJWTトークンにGithub Actionsが発行したJWTトークンの情報を紐づける
  attribute_mapping = {
    "google.subject"       = "assertion.sub"        # リポジトリ名と Git リファレンス
    "attribute.actor"      = "assertion.actor"      # Github Actions を実行したユーザーアカウント
    "attribute.repository" = "assertion.repository" # オーナーとリポジトリ名
  }
  # JWTトークンの発行元
  oidc { issuer_uri = "https://token.actions.githubusercontent.com" }
}

resource "google_project_iam_member" "github_actions" {
  project = var.project_id
  member  = "serviceAccount:${google_service_account.github_actions.email}"
  role    = "roles/iam.workloadIdentityUser"
}

resource "google_service_account_iam_binding" "github_actions" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions.name}/attribute.repository/${var.repository}"
  ]
  depends_on = [
    google_project_iam_member.github_actions
  ]
}