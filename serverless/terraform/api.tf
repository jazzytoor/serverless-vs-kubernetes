module "api" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name               = var.service
  protocol_type      = "HTTP"
  create_domain_name = false

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  routes = {
    "ANY /" = {
      integration = {
        uri                    = module.app.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }
    "GET /time" = {
      integration = {
        uri                    = module.app.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }
    "GET /visits" = {
      integration = {
        uri                    = module.app.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }
    "GET /home/{name}" = {
      integration = {
        uri                    = module.app.lambda_function_arn
        payload_format_version = "2.0"
        timeout_milliseconds   = 12000
      }
    }
  }

  tags = local.default_tags
}
