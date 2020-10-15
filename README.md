# securityautomation-demo-project

[![tflint](https://github.com/rhythmictech/securityautomation-demo-project/workflows/tflint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/securityautomation-demo-project/actions?query=workflow%3Atflint+event%3Apush+branch%3Amaster)
[![tfsec](https://github.com/rhythmictech/securityautomation-demo-project/workflows/tfsec/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/securityautomation-demo-project/actions?query=workflow%3Atfsec+event%3Apush+branch%3Amaster)
[![yamllint](https://github.com/rhythmictech/securityautomation-demo-project/workflows/yamllint/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/securityautomation-demo-project/actions?query=workflow%3Ayamllint+event%3Apush+branch%3Amaster)
[![misspell](https://github.com/rhythmictech/securityautomation-demo-project/workflows/misspell/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/securityautomation-demo-project/actions?query=workflow%3Amisspell+event%3Apush+branch%3Amaster)
[![pre-commit-check](https://github.com/rhythmictech/securityautomation-demo-project/workflows/pre-commit-check/badge.svg?branch=master&event=push)](https://github.com/rhythmictech/securityautomation-demo-project/actions?query=workflow%3Apre-commit-check+event%3Apush+branch%3Amaster)
<a href="https://twitter.com/intent/follow?screen_name=RhythmicTech"><img src="https://img.shields.io/twitter/follow/RhythmicTech?style=social&logo=twitter" alt="follow on Twitter"></a>

A terraform repository based on the [securityautomation-demo-project](https://github.com/cdaniluk/securityautomation-demo-project) example repository maintained by [Rhythmic](https://www.rhythmictech.com/). This project maps to the included PowerPoint presentation demonstrating how to use Terraform to drive and manage AWS native security functions.

## Pre-requisites
The demo integrates with PagerDuty, Jira and Slack. Webhooks for PagerDuty and Slack are required. Jira requires a Secret Manager secret to be created with an API token, along with a series of environment variables. This demo will still work
if the integrations are not in place, though obviously its usefulness as a demo will be reduced.

## Initial Setup

There is a handy setup script at `bin/setup.sh` which will create a
[terraform s3 backend](https://www.terraform.io/docs/backends/types/s3.html)
with locking via DynamoDB and add it's resources to your remote state.

1. Have an AWS account that is relatively unconfigured.
2. Install the prerequisites
    - `git`
    - `terraform` (We use [tfenv](https://github.com/tfutils/tfenv) to manage `terraform` versions)
    - `pre-commit`
    - `GNUMake`
3. [Provide authentication for the AWS provider](https://www.terraform.io/docs/providers/aws/index.html#authentication)
4. Set environment variables (or update `account/default.tfvars`):
   ```
   export TF_VAR_alert_webhook="[PAGERDUTY WEBHOOK]"
   export TF_VAR_notify_webhook="[SLACK WEBHOOK]"
   export TF_VAR_monitoring_jira_api_token_secret_name="[SECRET_NAME]" # use the name of the secret, not the ARN
   export TF_VAR_monitoring_jira_issue_type="[JIRA_ISSUE_TYPE]"
   export TF_VAR_monitoring_jira_project="[JIRA_PROJECT]"
   export TF_VAR_monitoring_jira_url="[JIRA_URL]"
   export TF_VAR_monitoring_jira_username="[JIRA_USERNAME]"
   export TF_VAR_slack_channel="[SLACK_CHANNEL]" # include the hash in the channel name
   ```
5. Clone the repo: `git clone https://github.com/cdaniluk/securityautomation-demo-project.git`
6. Update the values for the backend in `account/backend.auto.tfvars`
7. Run the setup with `make setup`
8. Run `make apply` in the `account`, `demo` and `security` projects.

## What It Does
Once fully applied, the following will be in place:

* CloudTrail logging to an S3 bucket and CloudWatch Log Group
* An IAM password policy
* An S3 bucket for bucket access logging
* An EC2 keypair that can be used if running [GuardDuty Tester](https://github.com/awslabs/amazon-guardduty-tester)
* A simple Lambda that logs random strings, along with a CloudWatch Event that triggers it every minute
* GuardDuty with notifications routing to PagerDuty
* CloudWatch Metric Filters/Alerts for all CIS required search strings routing to Slack
* AWS Config with notifications routing to Jira (note that no rules are created, so no notifications will actually occur)
* CloudWatch Metric Filter/Alert looking for the string `INVALID AUTHENTICATION ATTEMPT` is found
* SecurityHub with notifications routing to Slack (this is quite noisy)
