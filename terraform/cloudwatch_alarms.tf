resource "aws_cloudwatch_metric_alarm" "cpu_above_60" {
  alarm_name          = "ASG-EC2-APP-CPUUtilization-Above60"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = var.cpu_alarm_threshold

  alarm_description = "CPU utilization exceeded ${var.cpu_alarm_threshold}% on ${aws_autoscaling_group.main.name}."
  alarm_actions     = [aws_sns_topic.notifications.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}
