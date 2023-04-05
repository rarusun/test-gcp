## ディレクトリについて

github actionsからTerraformを実行するサービスアカウントと、接続するためのトークン発行のためのProviderとかを作成
一度作成したらほぼ変更しないつもり

## 初期設定

サービスアカウント設定のTerraformの実行を行う`terraform-account`を用意する必要がある

gcloud 実行コマンド
```
gcloud iam service-accounts create terraform-account --display-name "Used by Terraform on the local machine"

gcloud projects add-iam-policy-binding {project-id} --member ${service-account-email} --role roles/editor

gcloud projects add-iam-policy-binding {project-id} --member ${service-account-email} --role roles/iam.workloadIdentityPoolAdmin

gcloud projects add-iam-policy-binding {project-id} --member ${service-account-email} --role roles/iam.securityAdmin

gcloud projects add-iam-policy-binding {project-id} --member ${service-account-email} --role roles/iam.serviceAccountUser
```

## 参考
https://github.com/hashicorp/terraform-provider-google/issues/11789

poolを作成するときに`roles/iam.workloadIdentityPoolAdmin`が必要らしい

https://stackoverflow.com/questions/65661144/getting-error-while-allowing-accounts-and-roles-in-terraform-for-gcp

サービスアカウントにロールを渡すときに`roles/iam.securityAdmin`が必要らしい