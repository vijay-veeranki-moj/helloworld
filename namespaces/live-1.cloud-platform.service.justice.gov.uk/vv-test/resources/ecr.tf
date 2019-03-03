terraform {
  backend "s3" {}
}

provider "aws" {
  region = "eu-west-1"
}

module "vv-ecr-cred-news" {
  source    = "github.com/ministryofjustice/cloud-platform-terraform-ecr-credentials?ref=2.0"
  repo_name = "vv-ecr-cred-news"
  team_name = "test-webops-cred"
}

resource "kubernetes_secret" "vv-ecr-cred-news" {
  metadata {
    name      = "ecr-repo-vv-myapp-news"
    namespace = "vv-test"
  }

  data {
    repo_url          = "${module.vv-ecr-cred-news.repo_url}"
    access_key_id     = "${module.vv-ecr-cred-news.access_key_id}"
    secret_access_key = "${module.vv-ecr-cred-news.secret_access_key}"
  }
}
