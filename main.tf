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
  env_user_pair = flatten([
    for env in var.environments : [
      for user in var.users : {
        env      = env
        username = format("%s-%s", user, env)
      }
    ]
  ])
  env_users_mapping = flatten([
    for env in var.environments : {
      env   = env
      users = formatlist("%s-%s", var.users, env)
    }
  ])
}

module "iam_user" {
  for_each                      = { for t in local.env_user_pair : t.username => t }
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

module "iam_iam-group-with-policies" {
  depends_on  = [module.iam_user]
  for_each    = { for y in local.env_users_mapping : y.env => y }
  source      = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version     = "3.8.0"
  attach_iam_self_management_policy = true
  name        = each.key
  group_users = each.value["users"]
}

