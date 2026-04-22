resource "aws_launch_template" "main" {
  name          = "LT-EC2-SERVERAPP"
  description   = "Version 1.0"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.ec2_key.key_name

  network_interfaces {
    device_index    = 0
    security_groups = [aws_security_group.web_app.id]
  }
}
