resource "aws_iam_group" "billing_group" {
  name = "BillingUsers"

}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.billing_group.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/Billing"
}

resource "aws_iam_user" "simple_user" {
  name = "TheAccountant"
}

resource "aws_iam_group_membership" "team" {
  name  = aws_iam_group.billing_group.name
  group = aws_iam_group.billing_group.name
  users = [aws_iam_user.simple_user.name]
}

# A Lambda to log random strings
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "logSadThings.py"
  output_path = "${path.module}/tmp/logSadThing.zip"
}

data "aws_iam_policy_document" "assume" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role" {
  assume_role_policy = data.aws_iam_policy_document.assume.json
}

resource "aws_iam_role_policy_attachment" "role" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "log_sad_things" {
  filename      = data.archive_file.lambda.output_path
  function_name = "logSadThings"
  role          = aws_iam_role.role.arn
  handler       = "logSadThings.handler"
  runtime       = "python3.6"

  lifecycle {
    ignore_changes = [
      filename,
      last_modified,
    ]
  }

  source_code_hash = data.archive_file.lambda.output_base64sha256
}

resource "aws_cloudwatch_event_rule" "every-minute" {
  name                = "logSomethingSadEveryMinute"
  schedule_expression = "rate(1 minute)"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_event_target" "every-minute" {
  rule = aws_cloudwatch_event_rule.every-minute.name
  arn  = aws_lambda_function.log_sad_things.arn

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_permission" "log_sad_things" {
  statement_id_prefix = "AllowExecutionFromCloudWatch-"
  action              = "lambda:InvokeFunction"
  function_name       = aws_lambda_function.log_sad_things.function_name
  principal           = "events.amazonaws.com"
  source_arn          = aws_cloudwatch_event_rule.every-minute.arn

  lifecycle {
    create_before_destroy = true
  }
}
