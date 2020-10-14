# Account Settings

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.13.4 |
| aws | ~> 3.8 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alert\_webhook | Webhook to send alerts to | `string` | n/a | yes |
| bucket | Bucket that tfstate is stored in | `string` | n/a | yes |
| dynamodb\_table | DynamoDB table for locking/state management | `string` | n/a | yes |
| env | Environment being deployed to | `string` | n/a | yes |
| iam\_master\_account | n/a | `string` | n/a | yes |
| iam\_role\_prefix | n/a | `string` | n/a | yes |
| key | Key that tfstate is stored in | `string` | n/a | yes |
| monitoring\_jira\_api\_token\_secret\_name | AWS SecretsManager Secret name for Jira API token | `string` | n/a | yes |
| monitoring\_jira\_issue\_type | Jira Issue Type (key) | `string` | n/a | yes |
| monitoring\_jira\_project | Jira Project (key) | `string` | n/a | yes |
| monitoring\_jira\_url | Jira URL | `string` | n/a | yes |
| monitoring\_jira\_username | Jira username associated with API token | `string` | n/a | yes |
| namespace | Namespace to associate resources in this account with | `string` | n/a | yes |
| notify\_webhook | Webhook to send notifications to | `string` | n/a | yes |
| owner | Team/person responsible for this account | `string` | n/a | yes |
| region | Region resources are being deployed to | `string` | n/a | yes |
| slack\_channel | Channel to send notifications to | `string` | n/a | yes |
| tags | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudtrail\_log\_group | CloudTrail CloudWatch log group |
| s3\_bucket\_access\_logging | S3 bucket to receive S3 bucket access logs |
| sns\_topic\_alert\_arn | Alert Topic ARN |
| sns\_topic\_notify\_arn | Notification Topic ARN |
| sns\_topic\_ticket\_arn | Ticketing Topic ARN |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
