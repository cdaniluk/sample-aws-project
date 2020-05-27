# demo

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bucket | Bucket that tfstate is stored in | string | n/a | yes |
| dynamodb\_table | DynamoDB table for locking/state management | string | n/a | yes |
| env | Environment being deployed to | string | n/a | yes |
| key | Key that tfstate is stored in | string | n/a | yes |
| namespace | Namespace to associate resources in this account with | string | n/a | yes |
| owner | Team/person responsible for this account | string | n/a | yes |
| region | Region resources are being deployed to | string | n/a | yes |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
