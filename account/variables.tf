########################################
# General Vars
########################################

variable "iam_master_account" {
  type = string
}

variable "iam_role_prefix" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

########################################
# Monitoring Vars
########################################

variable "alert_webhook" {
  description = "Webhook to send alerts to"
  type = string
}

variable "notify_webhook" {
  description = "Webhook to send notifications to"
  type = string
}

variable "slack_channel" {
  description = "Channel to send notifications to"
  type = string
}

variable "ticket_webhook" {
  description = "Webhook to send tickets to"
  type = string
}