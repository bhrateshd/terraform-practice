#SNS Topic
resource "aws_sns_topic" "alerts" {
  name = "cloudwatch-alerts"
}

#Email Subscription
resource "aws_sns_topic_subscription" "email_alert" {
    topic_arn = aws_sns_topic.alerts.arn
    protocol = "email"
    endpoint = var.email
}

#CloudWatch Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_alerm" {
    alarm_name = "cpu-utilization"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    statistic = "Average"
    period = "120"
    threshold = "80"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 2

    alarm_description ="Alarm when CPU utilization is high"

    dimensions = {
        InstanceID = var.instance_id
    }

    alarm_actions = [aws_sns_topic.alerts.arn]  
}

