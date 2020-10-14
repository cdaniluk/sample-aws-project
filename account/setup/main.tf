module "tags" {
  source  = "rhythmictech/tags/terraform"
  version = "~> 1.1.0"

  names = [
    "account",
    var.env,
    var.namespace
  ]

  tags = merge({
    "Env"       = var.env,
    "Namespace" = var.namespace,
    "Owner"     = var.owner
  }, var.additional_tags)
}

module "s3logging-bucket" {
  source  = "rhythmictech/s3logging-bucket/aws"
  version = "~> 2.0.0"

  bucket_suffix = "account"
  tags          = module.tags.tags_no_name
}

module "backend" {
  source  = "rhythmictech/backend/aws"
  version = "~> 2.1.0"

  bucket = var.bucket
  region = var.region
  table  = var.dynamodb_table
  tags   = module.tags.tags_no_name

  logging_target_bucket = module.s3logging-bucket.s3_bucket_name
  logging_target_prefix = "tfstate-s3-logs/"
}
