# TODO this module is still experimental and has issues w/Jira integration
module "monitoring" {
  source = "git::https://github.com/rhythmictech/terraform-aws-rhythmic-monitoring?ref=demo"

  name = "SecAutomation"

  alert_webhook              = var.alert_webhook
  enable_jira_integration    = true
  jira_api_token_secret_name = var.monitoring_jira_api_token_secret_name
  jira_issue_type            = var.monitoring_jira_issue_type
  jira_project               = var.monitoring_jira_project
  jira_url                   = var.monitoring_jira_url
  jira_username              = var.monitoring_jira_username
  notify_webhook             = var.notify_webhook
  slack_channel              = var.slack_channel
  tags                       = local.tags
}
