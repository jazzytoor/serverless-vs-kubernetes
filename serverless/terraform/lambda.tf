module "image_build" {
  source = "terraform-aws-modules/lambda/aws//modules/docker-build"

  create_ecr_repo = true
  ecr_repo        = var.service

  use_image_tag = true
  image_tag     = "2.0"

  source_path = "../../app"
}

module "app" {
  source = "terraform-aws-modules/lambda/aws"

  function_name  = var.service
  handler        = "main.lambda_handler"
  runtime        = "python3.14"
  create_package = false

  image_uri     = module.image_build.image_uri
  package_type  = "Image"
  architectures = ["x86_64"]

  create_current_version_allowed_triggers = false
  allowed_triggers = {
    apigateway = {
      service    = "apigateway"
      source_arn = "${module.api.api_execution_arn}/*/*"
    }
  }

  tags = local.default_tags
}
