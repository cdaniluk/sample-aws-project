# =============================================
# Provider/Backend/Workspace Check
# =============================================
provider "aws" {
  region = var.region
}


terraform {
  required_version = "~> 0.13.4"

  backend "s3" {
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.8"
    }

    local = {
      source = "hashicorp/local"
    }
    archive = {
      source = "hashicorp/archive"
    }
  }
}

# Intentionally throws an error if the workspace doesn't match the env
# from https://github.com/rhythmictech/terraform-terraform-errorcheck
module "does_workspace_match_env" {
  source  = "rhythmictech/errorcheck/terraform"
  version = "~> 1.0.0"

  assert        = terraform.workspace == var.env
  error_message = "Change workspace to match env. Workspace: '${terraform.workspace}', env: '${var.env}'"
}

# =============================================
# Variables
# =============================================
variable "env" {
  description = "Environment being deployed to"
  type        = string
}

variable "region" {
  description = "Region resources are being deployed to"
  type        = string
}

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

variable "namespace" {
  description = "Namespace to associate resources in this account with"
  type        = string
}

variable "owner" {
  description = "Team/person responsible for this account"
  type        = string
}
