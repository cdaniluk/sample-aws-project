module "backend" {
  source  = "rhythmictech/backend/aws"
  version = "~> 2.1"

  bucket = var.bucket
  region = var.region
  table  = var.dynamodb_table
  tags   = var.tags
}
