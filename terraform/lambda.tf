resource "aws_lambda_function" "ec2_notifier" {
  function_name = "ParseEventBridgeToSNS"
  role          = "arn:aws:iam::727081712948:role/service-role/ParseEventBridgeToSNS-role-6rdhw3jh"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.14"
  timeout       = 3
  memory_size   = 128
  architectures = ["x86_64"]
  filename      = "../lambda/lambda_function.zip"
}

resource "aws_lambda_function_event_invoke_config" "ec2_notifier_destination" {
  function_name = aws_lambda_function.ec2_notifier.function_name

  destination_config {
    on_success {
      destination = aws_sns_topic.notifications.arn
    }
  }
}