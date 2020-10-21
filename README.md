# 概要

NestJS アプリケーションを AWS にデプロイするために、**Terraform で Elastic Beanstalk 等のインフラを構築**するためのレポジトリです。

DB について、Beanstalk のデフォルト設定で作成される RDS では環境削除時に RDS も削除されてしまうので、別で RDS を作成して Beanstalk 環境に関連付けをしています。

# 実行コマンド

機密情報に関しては、`terraform.tfvars`に記述せず、ローカルの環境変数に指定します。

```
$ export TF_VAR_account_id = 111XXXXXXX
$ export TF_VAR_db_username = XXXXXXXXX
$ export TF_VAR_db_password = XXXXXXXX
$ export TF_VAR_jwt_secret = XXXXXXXXXXX

環境変数の確認
$ env | grep TF_VAR

削除する場合は以下を実行
$ unset TF_VAR_account_id
```

Terraform の実行

```
$ terraform init
$ terraform plan
$ terraform apply
```

作成された Beanstalk 環境へアプリケーションのデプロイ

```
$ aws --region [リージョン名] elasticbeanstalk update-environment --environment-name $(terraform output eb_env_name) --version-label $(terraform output app_version)
```
