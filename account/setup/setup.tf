provider "aws" {
  region = var.region
}

variable "additional_tags" {
  default     = {}
  description = "Additional tags to add to supported resources"
  type        = map(string)
}

##################################################
# Global Vars
##################################################

variable "env" {
  default     = "default"
  description = "Environment being deployed to"
  type        = string
}

variable "namespace" {
  description = "Namespace of this project/system"
  type        = string
}

variable "owner" {
  description = "Team/person responsible for resources defined within this project"
  type        = string
}

variable "region" {
  description = "Region resources are being deployed to"
  type        = string
}

##################################################
# Backend State Vars
##################################################
variable "bucket" {
  description = "Bucket that tfstate is stored in"
  type        = string
}

variable "dynamodb_table" {
  description = "DynamoDB table for locking/state management"
  type        = string
}

variable "key" {
  description = "Key that tfstate is stored in"
  type        = string
}
