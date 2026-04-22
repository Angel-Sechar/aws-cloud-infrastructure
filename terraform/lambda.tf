resource "aws_lambda_function" "ec2_notifier" {
  function_name    = "ParseEventBridgeToSNS"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = var.lambda_runtime
  timeout          = var.lambda_timeout
  memory_size      = var.lambda_memory_size
  architectures    = ["x86_64"]
  filename         = "../lambda/lambda_function.zip"
  source_code_hash = filebase64sha256("../lambda/lambda_function.zip")

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.notifications.arn
    }
  }

}
