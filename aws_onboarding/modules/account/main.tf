# This file creates an AWS account and then calls the route53 module to create the DNS records for the account.

# Data block to get the current AWS account ID
data "aws_caller_identity" "current" {}

# Create the AWS account
resource "aws_organizations_account" "account" {
  name      = var.account_name
  email     = var.account_email
  parent_id = var.parent_id
  close_on_deletion = true
}

# Wait 30 seconds for the account to be created before attaching the policy
resource "time_sleep" "wait_30_seconds" {
  depends_on = [aws_organizations_account.account]
  create_duration = "30s"
}

# Create a policy to allow Route53 management
resource "aws_organizations_policy" "route53_policy" {
  count = var.is_first_account ? 1 : 0
  name = "Route53ManagementPolicy"
  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:*",
          "route53domains:*",
          "cloudfront:ListDistributions",
          "elasticloadbalancing:DescribeLoadBalancers",
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:GetBucketWebsite"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the Route53 policy to the account
resource "aws_organizations_policy_attachment" "route53_policy_attachment" {
  count     = var.is_first_account ? 1 : 0
  policy_id = aws_organizations_policy.route53_policy[0].id
  target_id = aws_organizations_account.account.id
}

#Create a Route53 hosted zone
resource "aws_route53_zone" "main" {
  count    = var.is_first_account && var.domain_name != null ? 1 : 0
  name     = var.domain_name
  depends_on = [time_sleep.wait_30_seconds]
}

# Create DNS records in the Route53 hosted zone
resource "aws_route53_record" "records" {
  count    = var.is_first_account && var.domain_name != null ? length(var.dns_records) : 0
  zone_id  = aws_route53_zone.main[0].zone_id
  name     = var.dns_records[count.index].name
  type     = var.dns_records[count.index].type
  ttl      = var.dns_records[count.index].ttl
  records  = var.dns_records[count.index].records
  depends_on = [aws_route53_zone.main]
}