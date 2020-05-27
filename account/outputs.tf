########################################
# Monitoring Outputs
########################################
output "sns_topic_alert_arn" {
  description = "Alert Topic ARN"
  value = module.monitoring.sns_topic_alert_arn
}

output "sns_topic_notify_arn" {
  description = "Notification Topic ARN"
  value = module.monitoring.sns_topic_notify_arn
}

output "sns_topic_ticket_arn" {
  description = "Ticketing Topic ARN"
  value = module.monitoring.sns_topic_ticket_arn
}

########################################
# Security Outputs
########################################

output "cloudtrail_log_group" {
  description = "CloudTrail CloudWatch log group"
  value       = module.cloudtrail-logging.cloudwatch_loggroup_name
}

output "s3_bucket_access_logging" {
  description = "S3 bucket to receive S3 bucket access logs"
  value       = module.s3logging-bucket.s3logging_bucket_name
}