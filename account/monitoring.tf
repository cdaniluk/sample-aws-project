
module "monitoring" {
  source = "git::https://github.com/rhythmictech/terraform-aws-rhythmic-monitoring?ref=demo"

  name           = "SecurityAutomationDemo-Monitoring"
  alert_webhook  = var.alert_webhook
  notify_webhook = var.notify_webhook
  slack_channel  = var.slack_channel
  tags           = local.tags
}
