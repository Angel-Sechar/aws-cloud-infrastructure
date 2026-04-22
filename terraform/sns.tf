resource "aws_sns_topic" "notifications" {
  name = "ASG-Notifications"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.notifications.arn
  protocol  = "email"
  endpoint  = var.sns_email
}
