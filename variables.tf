variable "region" {
  description = "AWS region"
  default     = "eu-west-2"
}

variable "users" {
  type    = list(string)
  default = ["nevsa", "cordelia", "kriste", "darleen", "wynnie", "vonnie", "emelita", "maurita", "devinne", "breena"]
}

variable "environments" {
  type    = list(string)
  default = ["dev", "qa", "uat", "test", "prod"]
}