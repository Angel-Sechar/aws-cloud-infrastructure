variable "lambda_role_arn" {
  description = "IAM role ARN for the Lambda function"
}

variable "eventbridge_role_arn" {
  description = "IAM role ARN for EventBridge to invoke Lambda"
}