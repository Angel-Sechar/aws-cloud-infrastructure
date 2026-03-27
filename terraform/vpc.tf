resource "aws_vpc" "ecommerce_campus_vpc" {
  cidr_block                           = "10.0.0.0/16"
  enable_dns_hostnames                 = false
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"

  tags = {
    Name  = "ecommerce-campus-vpc"
    Owner = "Angel Sechar"
  }
}