terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.28.0"
    }
  }
  backend "local" {}
}

provider "aws" {
  region = var.region
}

locals {
  env_users_table = flatten([
    for env in var.environments : [
      for user in var.users : {
        env      = env
        username = format("%s-%s", user, env)
      }
    ]
  ])
}

output "env_users_table" {
  value = local.env_users_table
}

module "iam_user" {
  for_each                      = { for t in local.env_users_table : t.username => t }
  source                        = "terraform-aws-modules/iam/aws//modules/iam-user"
  version                       = "3.8.0"
  name                          = each.key
  create_iam_access_key         = true
  force_destroy                 = true
  create_iam_user_login_profile = false
  tags = {
    env = each.value["env"]
  }
}

output "userdetails" {
  value = values(module.iam_user)[*]
}

