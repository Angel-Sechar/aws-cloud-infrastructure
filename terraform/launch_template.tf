resource "aws_launch_template" "main" {
  name          = "LT-EC2-SERVERAPP"
  description   = "Version 1.0"
  image_id      = "ami-06a73f9d93a3879b5"
  instance_type = "t2.micro"
  key_name      = "ecommerce-campus-key"

  network_interfaces {
    device_index    = 0
    security_groups = ["sg-02f15d9eea61e8a1d"]
  }
}