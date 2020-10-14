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
  type        = string
}

variable "monitoring_jira_api_token_secret_name" {
  description = "AWS SecretsManager Secret name for Jira API token"
  type        = string
}

variable "monitoring_jira_issue_type" {
  description = "Jira Issue Type (key)"
  type        = string
}

variable "monitoring_jira_project" {
  description = "Jira Project (key)"
  type        = string
}

variable "monitoring_jira_url" {
  description = "Jira URL"
  type        = string
}

variable "monitoring_jira_username" {
  description = "Jira username associated with API token"
  type        = string
}

variable "notify_webhook" {
  description = "Webhook to send notifications to"
  type        = string
}

variable "slack_channel" {
  description = "Channel to send notifications to"
  type        = string
}
