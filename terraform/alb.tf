resource "aws_lb" "main" {
  name               = "LB-EC2-01"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_app.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
  idle_timeout       = 60

  enable_deletion_protection = true
}

resource "aws_lb_target_group" "main" {
  name        = "TG-EC2-ECOMMERCE-01"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.ecommerce_campus_vpc.id
  target_type = "instance"

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
