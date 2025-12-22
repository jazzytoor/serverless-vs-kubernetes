locals {
  sso_instance_id  = tolist(data.aws_ssoadmin_instances.sso_instance.identity_store_ids)[0]
  sso_instance_arn = tolist(data.aws_ssoadmin_instances.sso_instance.arns)[0]

  default_tags = {
    Name = var.service
  }
}
