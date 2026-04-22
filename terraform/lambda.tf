resource "aws_lambda_function" "ec2_notifier" {
  function_name = "ParseEventBridgeToSNS"
  role          = var.lambda_role_arn
  handler       = "lambda_function.lambda_handler"
  runtime       = var.lambda_runtime
  timeout       = var.lambda_timeout
  memory_size   = var.lambda_memory_size
  architectures = ["x86_64"]
  filename      = "../lambda/lambda_function.zip"
}
