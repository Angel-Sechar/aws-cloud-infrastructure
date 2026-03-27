resource "aws_cloudwatch_metric_alarm" "cpu_above_60" {
  alarm_name          = "ASG-EC2-APP-CPUUtilization-Above60"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 60

  alarm_description = "Triggers when CPU exceeds 60% for ASG-EC2-APP."
  alarm_actions     = [aws_sns_topic.notifications.arn]

  dimensions = {
    AutoScalingGroupName = "ASG-EC2-APP"
  }
}