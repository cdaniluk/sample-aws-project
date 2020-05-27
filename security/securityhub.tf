
module "securityhub" {
  source = "git::https://github.com/rhythmictech/terraform-aws-securityhub-to-sns?ref=demo"

  name                              = "SecurityHub-Demo"
  custom_action_notification_arn    = data.terraform_remote_state.account.outputs.sns_topic_ticket_arn
  imported_finding_notification_arn = data.terraform_remote_state.account.outputs.sns_topic_notify_arn
}
