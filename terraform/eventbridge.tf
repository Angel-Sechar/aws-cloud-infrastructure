resource "aws_cloudwatch_event_rule" "ec2_launched" {
  name        = "Event-EC2-Launched"
  description = "Triggers notification when a new EC2 instance is launched by ASG-EC2-APP."

  event_pattern = jsonencode({
    source      = ["aws.autoscaling"]
    detail-type = ["EC2 Instance Launch Successful"]
    detail = {
      AutoScalingGroupName = ["ASG-EC2-APP"]
    }
  })
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule     = aws_cloudwatch_event_rule.ec2_launched.name
  arn      = aws_lambda_function.ec2_notifier.arn
  role_arn = var.eventbridge_role_arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ec2_notifier.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_launched.arn
}