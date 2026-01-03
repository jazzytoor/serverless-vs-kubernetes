module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 5.0"

  bucket_prefix = "${local.subdomain}-"

  attach_policy = true
  policy        = data.aws_iam_policy_document.s3_policy.json

  tags = local.default_tags
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3.s3_bucket_arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [module.cloudfront.cloudfront_distribution_arn]
    }
  }
}

module "object" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/object"
  version = "~> 5.0"

  bucket       = module.s3.s3_bucket_id
  key          = "index.html"
  content_type = "text/html"

  file_source = "../../frontend/index.html"

  tags = local.default_tags
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 6.0"

  validation_method = "DNS"

  domain_name               = var.domain
  zone_id                   = data.aws_route53_zone.this.id
  subject_alternative_names = ["${local.subdomain}.${var.domain}"]

  tags = local.default_tags
}

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 6.0"

  aliases = ["${local.subdomain}.${var.domain}"]

  default_root_object = "index.html"

  origin = {
    s3 = {
      domain_name               = module.s3.s3_bucket_bucket_regional_domain_name
      origin_access_control_key = "s3"
    }
  }

  origin_access_control = {
    s3 = {
      description      = "CloudFront access to S3"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  viewer_certificate = {
    acm_certificate_arn = module.acm.acm_certificate_arn
    ssl_support_method  = "sni-only"
  }
}

module "records" {
  source  = "terraform-aws-modules/route53/aws"
  version = "~> 6.0"

  create_zone = false
  name        = var.domain

  records = {
    cloudfront = {
      name = local.subdomain
      type = "A"
      alias = {
        name    = module.cloudfront.cloudfront_distribution_domain_name
        zone_id = module.cloudfront.cloudfront_distribution_hosted_zone_id
      }
    }
  }
}
