# terraform {
#   backend "s3" {
#     bucket       = "jt-yeet"
#     encrypt      = true
#     key          = "terraform/${SERVICE}/.terraform/terraform.tfstate"
#     region       = "${AWS_REGION}"
#     use_lockfile = true
#   }
# }
