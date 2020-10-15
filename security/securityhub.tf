module "securityhub" {
  source  = "rhythmictech/securityhub-to-sns/aws"
  version = "~> 0.0.2"

  name                              = "SecurityHub-Demo"
  custom_action_notification_arn    = data.terraform_remote_state.account.outputs.sns_topic_ticket_arn
  imported_finding_notification_arn = data.terraform_remote_state.account.outputs.sns_topic_notify_arn
}
