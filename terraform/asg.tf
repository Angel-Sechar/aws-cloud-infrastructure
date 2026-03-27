resource "aws_autoscaling_group" "main" {
  name = "ASG-EC2-APP"

  min_size         = 1
  max_size         = 3
  desired_capacity = 1

  vpc_zone_identifier = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id
  ]

  target_group_arns = [aws_lb_target_group.main.arn]

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ASG-EC2-APP"
    propagate_at_launch = true
  }
}