module "awsconfig" {
  source  = "rhythmictech/config/aws"
  version = "~> 0.0.2"

  logging_bucket = data.terraform_remote_state.account.outputs.s3_bucket_access_logging
  region         = var.region
  sns_topic_arn  = data.terraform_remote_state.account.outputs.sns_topic_ticket_arn
}
