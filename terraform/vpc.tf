resource "aws_vpc" "ecommerce_campus_vpc" {
  cidr_block                           = var.vpc_cidr
  enable_dns_hostnames                 = false
  enable_dns_support                   = true
  enable_network_address_usage_metrics = false
  instance_tenancy                     = "default"

  tags = {
    Name  = "ecommerce-campus-vpc"
    Owner = var.owner
  }
}
