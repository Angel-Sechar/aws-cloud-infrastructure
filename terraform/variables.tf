variable "aws_region" {
  description = "AWS region where all resources will be deployed."
  type        = string
  default     = "sa-east-1"
}

variable "owner" {
  description = "Owner tag applied to resources for identification."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  description = "CIDR block for public subnet A."
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  description = "CIDR block for public subnet B."
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_a_cidr" {
  description = "CIDR block for private subnet A."
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_b_cidr" {
  description = "CIDR block for private subnet B."
  type        = string
  default     = "10.0.4.0/24"
}

variable "availability_zone_a" {
  description = "First availability zone."
  type        = string
  default     = "sa-east-1a"
}

variable "availability_zone_b" {
  description = "Second availability zone."
  type        = string
  default     = "sa-east-1c"
}

variable "instance_type" {
  description = "EC2 instance type for the Auto Scaling Group."
  type        = string
  default     = "t2.micro"
}

variable "asg_min_size" {
  description = "Minimum number of instances in the Auto Scaling Group."
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum number of instances in the Auto Scaling Group."
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group."
  type        = number
  default     = 1
}

variable "cpu_scale_out_threshold" {
  description = "CPU utilization percentage that triggers the CloudWatch alarm and scale-out policy."
  type        = number
  default     = 60
}

variable "cpu_scale_in_threshold" {
  description = "CPU utilization percentage that triggers the CloudWatch alarm and scale-in policy."
  type        = number
  default     = 30
}

variable "scale_out_evaluation_periods" {
  description = "Number of periods CPU must be above threshold before scaling out."
  type        = number
  default     = 2
}

variable "scale_in_evaluation_periods" {
  description = "Number of periods CPU must be below threshold before scaling in."
  type        = number
  default     = 3
}

variable "alarm_period" {
  description = "Period in seconds for CloudWatch alarm evaluation."
  type        = number
  default     = 120
}

variable "sns_email" {
  description = "Email address that will receive SNS notifications."
  type        = string
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function."
  type        = string
  default     = "python3.14"
}

variable "lambda_timeout" {
  description = "Timeout in seconds for the Lambda function."
  type        = number
  default     = 3
}

variable "lambda_memory_size" {
  description = "Memory size in MB for the Lambda function."
  type        = number
  default     = 128
}
