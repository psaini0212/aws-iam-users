output "user_details" {
  value = flatten([
    for v in values(module.iam_user)[*] : [
      format("Username: %s, Access Key Id: %s, Secret Access Key: %s", v.this_iam_user_name, v.this_iam_access_key_id, v.this_iam_access_key_secret)
    ]
  ])
}

