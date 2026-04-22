resource "aws_launch_template" "main" {
  name          = "LT-EC2-SERVERAPP"
  description   = "Version 1.0"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    device_index    = 0
    security_groups = [var.security_group_id]
  }
}
