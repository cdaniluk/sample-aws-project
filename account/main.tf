module "tags" {
  source  = "rhythmictech/tags/terraform"
  version = "~> 1.1"

  names = [
    "account",
    var.env,
    var.namespace
  ]

  tags = merge(var.tags, {
    "Env"       = var.env,
    "Namespace" = var.namespace,
    "Owner"     = var.owner
  })
}

locals {
  tags = module.tags.tags_no_name
}

module "s3logging-bucket" {
  source  = "rhythmictech/s3logging-bucket/aws"
  version = "~> 2.0.0"

  bucket_suffix = "account"
  tags          = local.tags
}

module "cloudtrail-bucket" {
  source  = "rhythmictech/cloudtrail-bucket/aws"
  version = "~> 1.3.1"

  logging_bucket = module.s3logging-bucket.s3_bucket_name
  region         = var.region
  tags           = local.tags
}

module "cloudtrail-logging" {
  source  = "rhythmictech/cloudtrail-logging/aws"
  version = "~> 1.3.0"

  cloudtrail_bucket = module.cloudtrail-bucket.s3_bucket_name
  kms_key_id        = module.cloudtrail-bucket.kms_key_id
  region            = var.region
}

module "iam-password-policy" {
  source  = "rhythmictech/iam-password-policy/aws"
  version = "~> 1.0.0"
}

module "keypair" {
  source  = "rhythmictech/secretsmanager-keypair/aws"
  version = "~> 0.0.3"

  name_prefix = "instance-keypair"
  description = "SSH keypair for instances"
}
