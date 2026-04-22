resource "aws_cloudwatch_metric_alarm" "cpu_above_60" {
  alarm_name          = "ASG-EC2-APP-CPUUtilization-Above${var.cpu_scale_out_threshold}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.scale_out_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.cpu_scale_out_threshold

  alarm_description = "CPU utilization exceeded ${var.cpu_scale_out_threshold}% on ${aws_autoscaling_group.main.name}."

  alarm_actions = [
    aws_autoscaling_policy.scale_out.arn,
    aws_sns_topic.notifications.arn,
  ]

  ok_actions = [
    aws_autoscaling_policy.scale_in.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_below_30" {
  alarm_name          = "ASG-EC2-APP-CPUUtilization-Below${var.cpu_scale_in_threshold}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.scale_in_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.cpu_scale_in_threshold

  alarm_description = "CPU utilization dropped below ${var.cpu_scale_in_threshold}% on ${aws_autoscaling_group.main.name}."

  alarm_actions = [
    aws_autoscaling_policy.scale_in.arn,
  ]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.main.name
  }
}
