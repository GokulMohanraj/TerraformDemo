provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "demo" {
  ami           = "ami-0d2614eafc1b0e4d2"
  instance_type = var.instance_type

  tags = {
    Name = "Demo"
  }
}

resource "aws_sns_topic" "demo_sns" {
  display_name = "Demo SNS"
}

resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = aws_sns_topic.demo_sns.arn
  protocol  = "email"
  endpoint  = var.email
}

resource "aws_cloudwatch_event_rule" "ec2_state_change_rule" {
  name        = "ec2-instance-state-change-rule"
  description = "Triggers on EC2 instance state changes (stopped/terminated)"

  event_pattern = jsonencode({
    source      = ["aws.ec2"],
    detail-type = ["EC2 Instance State-change Notification"],
    detail = {
      state         = ["stopped", "terminated"],  # Triggers on stopped/terminated states
      "instance-id" = [aws_instance.demo.id],     # Specific instance ID
    },
  })
}

resource "aws_cloudwatch_event_target" "sns_target" {
  rule = aws_cloudwatch_event_rule.ec2_state_change_rule.name
  arn  = aws_sns_topic.demo_sns.arn
}


