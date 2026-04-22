# AWS Cloud Infrastructure

Skip the console. Skip the manual steps. Skip the "works on my account" problem.

This solution gives you → multi-AZ VPC, Auto Scaling on real load, and
an EventBridge → Lambda → SNS pipeline that knows before you do.
Managed entirely in Terraform.

---

## Architecture

![Architecture Diagram](docs/AWS-Architecture.png)

### Notification flows

#### CloudWatch

![CloudWatch Notification](docs/AWS-CloudWatch-Notification.png)

#### EventBridge

![Event EC2 Launch Notification](docs/AWS-Event-Notification.png)

---

## Technologies

- **AWS VPC** — isolated network with public and private subnets across 2 availability zones
- **AWS EC2** — auto scaled instances managed by a launch template
- **AWS ALB** — application load balancer distributing traffic across EC2 instances
- **AWS Auto Scaling** — automatically adjusts EC2 capacity based on CPU utilization
- **AWS NAT Gateway** — outbound internet access for EC2 instances in private subnets
- **AWS EventBridge** — event rule that detects new EC2 instance launches
- **AWS Lambda** — Python function triggered by EventBridge to send notifications
- **AWS SNS** — topic that delivers email notifications to subscribers
- **AWS CloudWatch** — alarm that triggers when CPU exceeds 60%
- **AWS IAM** — roles and policies for Lambda and EventBridge, managed by Terraform
- **Terraform** — infrastructure as code managing all resources

---

## Infrastructure Overview

### Networking

A VPC (`10.0.0.0/16`) with 2 public and 2 private subnets spread across availability zones `sa-east-1a` and `sa-east-1c`. Public subnets route traffic through an Internet Gateway. Private subnets route outbound traffic through a NAT Gateway. All routing is defined in a single `route_tables.tf` file. EC2 instances run in private subnets and are not directly reachable from the internet.

### Compute

An Auto Scaling Group manages EC2 instances (`t2.micro`) using a launch template. The AMI is automatically resolved to the latest Amazon Linux 2023 image for the deployment region. The key pair is generated and managed by Terraform. The ASG has a minimum of 1, desired of 1, and maximum of 3 instances.

### Security

A security group is created and managed by Terraform, allowing inbound HTTP (port 80) and SSH (port 22) traffic, and all outbound traffic. EC2 instances are only reachable through the ALB — not directly from the internet.

### Load Balancing

An Application Load Balancer sits in the public subnets, listening on port 80 (HTTP) and forwarding traffic to the EC2 target group with health checks enabled.

### Event-Driven Notifications

When the ASG launches a new EC2 instance, EventBridge detects the event and triggers a Lambda function. The Lambda function uses an SNS destination to deliver an email notification to the subscriber.

### Monitoring

A CloudWatch alarm monitors average CPU utilization of the ASG. When CPU exceeds 60%, it triggers an SNS notification via email.

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [AWS CLI](https://aws.amazon.com/cli/) configured with valid credentials
- AWS account

```bash
aws configure
```

### Terraform Providers

- AWS (`hashicorp/aws`) ~> 6.0
- TLS (`hashicorp/tls`) ~> 4.0
- Local (`hashicorp/local`) ~> 2.0

---

## Usage

### 1. Clone the repository

```bash
git clone git@github.com:your-username/aws-cloud-infrastructure.git
cd aws-cloud-infrastructure
```

### 2. Configure AWS credentials

```bash
aws configure
```

### 3. Fill in your variables

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
```

Edit `terraform.tfvars` and replace `owner` and `sns_email` with your own values. Variables with defaults do not need to be changed unless you want to customize the infrastructure.

### 4. Deploy

```bash
cd terraform
terraform init
terraform apply
```

Review the plan and type `yes` when prompted. Once complete, Terraform will output the ALB DNS name, ASG name, Lambda function name, and SNS topic ARN.

### 5. Confirm SNS subscription

AWS will send a confirmation email to the address set in `sns_email`. Click the confirmation link to start receiving notifications.

### 6. SSH access

Terraform generates a key pair automatically and saves the private key as `ec2-key-<owner>.pem` inside the `terraform/` folder.

```bash
chmod 400 terraform/ec2-key-<owner>.pem
ssh -i terraform/ec2-key-<owner>.pem ec2-user@<instance-ip>
```

---

## Project Structure

```
aws-cloud-infrastructure/
├── .github/
│   └── workflows/
│       └── terraform.yml
├── docs/
│   ├── AWS-Architecture.png
│   ├── AWS-CloudWatch-Notification.png
│   ├── AWS-Event-Notification.png
│   └── screenshots/
├── lambda/
│   ├── lambda_function.py
│   └── lambda_function.zip
└── terraform/
    ├── provider.tf
    ├── variables.tf
    ├── outputs.tf
    ├── vpc.tf
    ├── subnets.tf
    ├── internet_gateway.tf
    ├── nat_gateway.tf
    ├── route_tables.tf
    ├── sg.tf
    ├── iam.tf
    ├── ami.tf
    ├── key_pair.tf
    ├── alb.tf
    ├── launch_template.tf
    ├── asg.tf
    ├── sns.tf
    ├── lambda.tf
    ├── eventbridge.tf
    ├── cloudwatch_alarms.tf
    └── terraform.tfvars.example
```

---

## Screenshots

### VPC & Networking

![VPC](docs/screenshots/vpc.png)

### Auto Scaling Group

#### ASG Details

![ASG Details](docs/screenshots/asg-details.png)

#### ASG Activity

![ASG Activity](docs/screenshots/asg-activity.png)

#### ASG Instance Management

![ASG Instance Management](docs/screenshots/asg-instancemanagement.png)

#### ASG Metrics

![ASG Metrics](docs/screenshots/asg-metrics.png)

### Application Load Balancer

#### Network

![ALB Network](docs/screenshots/alb-network.png)

#### Listeners and Rules

![ALB Listeners & Rules](docs/screenshots/alb-listenersrules.png)

### EventBridge

![EventBridge Event Pattern](docs/screenshots/eventbridge-eventpattern.png)

### Lambda

#### Triggers

![Lambda Triggers](docs/screenshots/lambda-triggers.png)

#### Destinations

![Lambda Destinations](docs/screenshots/lambda-destinations.png)

### SNS

![SNS Subscriptions](docs/screenshots/sns-subscriptions.png)

### CloudWatch

#### CloudWatch Definition

![CloudWatch Definition](docs/screenshots/cloudwatch-definition.png)

#### CloudWatch Metrics

![CloudWatch Metrics](docs/screenshots/cloudwatch-metrics.png)

### Email Notifications

#### CloudWatch Alert

![Email CloudWatch Alert](docs/screenshots/email-cloudwatch.png)

#### EventBridge Alert

![Email EC2 Launch Notification](docs/screenshots/email-eventec2launched.png)

### Security Group

![Security Group](docs/screenshots/sg-webapplication.png)

---

## Author

**Angel Sechar**
[GitHub](https://github.com/Angel-Sechar) · [LinkedIn](https://www.linkedin.com/in/angel-sechar-valdez/)
