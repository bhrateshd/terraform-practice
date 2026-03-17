If you need to explain the CloudWatch Alarm setup using Terraform (step-by-step) in an interview, documentation, or presentation, explain it in this structure:

1️⃣ Project structure
2️⃣ Files used
3️⃣ What is written in each file
4️⃣ Terraform workflow
5️⃣ What happens after deployment

I’ll show you a clear explanation format you can use.

1️⃣ Project Structure

For this setup we created a simple Terraform project.

terraform-cloudwatch-alarm/
│
├── provider.tf
├── variables.tf
├── main.tf
├── terraform.tfvars
└── outputs.tf
Explanation
File	Purpose
provider.tf	Configure AWS provider
variables.tf	Define input variables
main.tf	Create SNS and CloudWatch Alarm
terraform.tfvars	Store variable values
outputs.tf	Display output values
2️⃣ provider.tf

This file configures the AWS provider.

provider "aws" {
  region = "ap-south-1"
}
Explanation

This tells Terraform we are using AWS as the cloud provider

region specifies where resources will be created.

You can mention:
We are using the AWS monitoring service Amazon CloudWatch to monitor infrastructure metrics.

3️⃣ variables.tf

This file defines reusable variables.

variable "instance_id" {
  description = "EC2 instance ID"
}

variable "email" {
  description = "Email for alerts"
}

variable "cpu_threshold" {
  description = "CPU threshold"
  default     = 80
}
Explanation

We define variables so that values can be reused and easily modified.

Example:

EC2 Instance ID

Alert Email

CPU threshold

4️⃣ terraform.tfvars

This file contains actual values for variables.

instance_id   = "i-123456789"
email         = "devopsalerts@gmail.com"
cpu_threshold = 80
Explanation

Instead of hardcoding values inside .tf files, we pass them through terraform.tfvars.

5️⃣ main.tf

This file contains the actual infrastructure configuration.

Step 1 — Create SNS Topic
resource "aws_sns_topic" "alerts" {
  name = "cloudwatch-alerts"
}

Explanation:

SNS topic will send notifications when alarm triggers.

This uses Amazon Simple Notification Service.

Step 2 — Email Subscription
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.email
}

Explanation:

This subscribes an email address to the SNS topic.

When alarm triggers → email will be sent.

Step 3 — Create CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {

  alarm_name          = "HighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = var.cpu_threshold

  dimensions = {
    InstanceId = var.instance_id
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
}

Explanation:

This alarm monitors EC2 CPU utilization.

Key parameters:

Parameter	Meaning
metric_name	CPUUtilization
namespace	AWS/EC2
threshold	Alarm if CPU > 80%
period	Metric evaluation time
evaluation_periods	Number of checks
alarm_actions	Trigger SNS notification


1️⃣ dimensions Block
dimensions = {
  InstanceId = var.instance_id
}
What is a Dimension?

In CloudWatch, dimensions are key-value pairs used to identify a specific resource for a metric.

Many AWS services send metrics to CloudWatch, so dimensions help CloudWatch know which exact resource to monitor.

Example

For EC2 CPU monitoring:

Metric: CPUUtilization
Namespace: AWS/EC2
Dimension: InstanceId

So the alarm must know which EC2 instance to monitor.

Terraform Explanation
InstanceId = var.instance_id

Meaning:

InstanceId → CloudWatch dimension key

var.instance_id → EC2 instance ID passed from variables

Example actual value:

InstanceId = i-0abc123456789xyz

So the alarm monitors CPU utilization of that specific EC2 instance.

Without Dimension

If we didn’t use dimensions:

CloudWatch would not know which instance's CPU metric to monitor.

Simple Example
AWS/EC2
   │
   ├── Instance i-123
   ├── Instance i-456
   └── Instance i-789

Using dimension:

InstanceId = i-123

The alarm monitors only instance i-123.

2️⃣ alarm_actions
alarm_actions = [aws_sns_topic.alerts.arn]

This defines what action should happen when the alarm triggers.

When the metric crosses the threshold:

CPU > 80%

CloudWatch changes alarm state to:

ALARM

Then it executes the action defined here.

In Our Setup

The action is sending a notification to an **Amazon Simple Notification Service topic.

alarm_actions = [aws_sns_topic.alerts.arn]

Meaning:

When alarm triggers →

CloudWatch Alarm
        │
        ▼
SNS Topic
        │
        ▼
Email Notification
Why ARN is used?

The SNS topic is identified using its ARN (Amazon Resource Name).

Example ARN:

arn:aws:sns:ap-south-1:123456789012:cloudwatch-alerts

Terraform automatically fetches it using:

aws_sns_topic.alerts.arn






6️⃣ outputs.tf
output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}

Explanation:

This displays the SNS topic ARN after Terraform deployment.

7️⃣ Terraform Deployment Steps

We executed the following commands.

Step 1 — Initialize Terraform
terraform init

Explanation:

Downloads AWS provider plugin

Initializes Terraform project

Step 2 — Validate Configuration
terraform validate

Explanation:

Checks Terraform syntax and configuration errors.

Step 3 — Review Execution Plan
terraform plan

Explanation:

Shows what Terraform will create:

+ aws_sns_topic
+ aws_sns_topic_subscription
+ aws_cloudwatch_metric_alarm
Step 4 — Apply Configuration
terraform apply

Explanation:

Terraform creates the resources in AWS.

8️⃣ Final Architecture
EC2 Instance
      │
      │ metrics
      ▼
CloudWatch
      │
      │ threshold check
      ▼
CloudWatch Alarm
      │
      ▼
SNS Topic
      │
      ▼
Email Notification
9️⃣ Short Interview Explanation (Best Answer)

You can explain like this:

We created a CloudWatch alarm using Terraform to monitor EC2 CPU utilization. First we configured the AWS provider in provider.tf. Then we defined variables like instance ID and alert email in variables.tf. In main.tf we created an SNS topic, an email subscription, and a CloudWatch metric alarm that monitors CPU utilization. If CPU usage exceeds the defined threshold, the alarm triggers and sends a notification through SNS to the configured email. Finally we deployed the infrastructure using terraform init, plan, and apply.





1️⃣ SNS Topic

Amazon Simple Notification Service (SNS) Topic is a communication channel used to send messages or alerts to multiple subscribers.

In simple words:

An SNS topic acts like a notification hub where messages are published and delivered to all subscribers.

Example in our CloudWatch setup

When the alarm triggers:

CloudWatch Alarm
       │
       ▼
SNS Topic
       │
       ▼
Subscribers (Email / SMS / Lambda / HTTP)
Terraform example
resource "aws_sns_topic" "alerts" {
  name = "cloudwatch-alerts"
}
Explanation

This creates an SNS topic named cloudwatch-alerts

CloudWatch will send alarm notifications to this topic.

2️⃣ Email Subscription

An Email Subscription means registering an email address to receive notifications from the SNS topic.

So whenever a message is published to the topic → the email subscriber receives the alert.

Example
SNS Topic
     │
     ├── Email Subscriber
     ├── SMS Subscriber
     ├── Lambda
     └── HTTP endpoint
Terraform example
resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "example@gmail.com"
}
Explanation

topic_arn → SNS topic to subscribe to

protocol = email → Notification method

endpoint → Email address

⚠️ After Terraform apply, AWS sends confirmation email.
You must confirm the subscription before alerts start working.

3️⃣ ARN (Amazon Resource Name)

An ARN is the unique identifier for an AWS resource.

Every resource in AWS has its own ARN.

Example ARN:

arn:aws:sns:ap-south-1:123456789012:cloudwatch-alerts
ARN structure
arn:partition:service:region:account-id:resource

Example:

Part	Meaning
arn	AWS identifier
aws	partition
sns	service
ap-south-1	region
account-id	AWS account
resource	resource name
Why ARN is used

ARN helps AWS services communicate with each other.

Example in our Terraform code:

alarm_actions = [aws_sns_topic.alerts.arn]

Explanation:

When the CloudWatch alarm triggers

It uses the SNS topic ARN to send the notification.

4️⃣ Complete Flow of Your Setup
EC2 Instance
      │
      ▼
CloudWatch Metric (CPUUtilization)
      │
      ▼
CloudWatch Alarm
      │
      ▼
SNS Topic
      │
      ▼
Email Subscription
      │
      ▼
Alert Email Sent
5️⃣ Simple Interview Answer

If interviewer asks:

What is SNS topic, email subscription, and ARN?

You can say:

SNS topic is a messaging channel used to send notifications to multiple subscribers. Email subscription is when we register an email address to receive alerts from the SNS topic. ARN stands for Amazon Resource Name and it uniquely identifies AWS resources, which allows services like CloudWatch to send notifications to the SNS topic.