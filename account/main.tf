module "tags" {
  source = "git::https://github.com/rhythmictech/terraform-terraform-tags.git?ref=v1.0.0"

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
  source        = "git::https://github.com/rhythmictech/terraform-aws-s3logging-bucket?ref=v1.0.1"
  bucket_suffix = "account"
  region        = var.region
  tags          = local.tags
}

module "cloudtrail-bucket" {
  source         = "git::https://github.com/rhythmictech/terraform-aws-cloudtrail-bucket?ref=v1.2.0"
  logging_bucket = module.s3logging-bucket.s3logging_bucket_name
  region         = var.region
  tags           = local.tags

}

module "cloudtrail-logging" {
  source            = "git::https://github.com/rhythmictech/terraform-aws-cloudtrail-logging?ref=v1.1.0"
  cloudtrail_bucket = module.cloudtrail-bucket.s3_bucket_name
  kms_key_id        = module.cloudtrail-bucket.kms_key_id
  region            = var.region
}

module "iam-password-policy" {
  source = "git::https://github.com/rhythmictech/terraform-aws-iam-password-policy?ref=v1.0.0"
}
