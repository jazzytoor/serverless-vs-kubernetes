provider "aws" {
  region = "us-east-1"
}

provider "docker" {
  host = "unix:///Users/jazztoor/.docker/run/docker.sock"
  registry_auth {
    address  = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.current.region)
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}
