data "terraform_remote_state" "account" {
  backend = "s3"
  config = {
    bucket = var.bucket
    key    = "account.tfstate"
    region = var.region
  }
}

module "cis-cloudwatch-monitors" {
  source = "rhythmictech/cis-cloudwatch-monitors/aws"

  default_period   = 60
  notification_arn = data.terraform_remote_state.account.outputs.sns_topic_notify_arn
  log_group        = data.terraform_remote_state.account.outputs.cloudtrail_log_group
}

module "guardduty" {
  source = "rhythmictech/guardduty-to-sns/aws"

  finding_publishing_frequency = "FIFTEEN_MINUTES"
  notification_arn             = data.terraform_remote_state.account.outputs.sns_topic_alert_arn
}

resource "aws_cloudwatch_log_metric_filter" "find_sad_things" {
  name = "find_sad_things"

  log_group_name = "/aws/lambda/logSadThings"
  pattern        = "INVALID AUTHENTICATION ATTEMPT"

  metric_transformation {
    default_value = 0
    name          = "SadThingsCount"
    namespace     = "ApplicationMonitoring"
    value         = 1
  }
}

resource "aws_cloudwatch_metric_alarm" "find_sad_things" {
  alarm_name = "find_sad_things"

  alarm_actions       = [data.terraform_remote_state.account.outputs.sns_topic_notify_arn]
  alarm_description   = "Unsuccessful logins detected"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "SadThingsCount"
  namespace           = "ApplicationMonitoring"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  treat_missing_data  = "notBreaching"
}
