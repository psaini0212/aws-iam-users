variable "region" {
  description = "AWS region"
  default     = "eu-west-2"
}

variable "users" {
  description = "List of Users"
  type    = list(string)
  default = ["nevsa", "cordelia", "kriste", "darleen", "wynnie", "vonnie", "emelita", "maurita", "devinne", "breena"]
}

variable "environments" {
  description = "List of Environments"
  type    = list(string)
  default = ["dev", "qa", "uat", "test", "prod"]
}
