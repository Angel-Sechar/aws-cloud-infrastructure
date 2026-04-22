output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.main.dns_name
}

output "asg_name" {
  description = "Name of the Auto Scaling Group."
  value       = aws_autoscaling_group.main.name
}

output "lambda_function_name" {
  description = "Name of the Lambda function."
  value       = aws_lambda_function.ec2_notifier.function_name
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic."
  value       = aws_sns_topic.notifications.arn
}
