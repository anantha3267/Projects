resource "aws_wafv2_web_acl" "example" {
  name        = "web-acl-sqli-xss-geo"
  description = "WAF to block SQLi, XSS, and non-US traffic"
  
  scope = "REGIONAL"  # Specifies that this WAF applies to regional AWS services (like ALB)
  
  default_action {
    block {}  # Default action: Block all traffic that doesn’t match any rules
  }

  # SQL Injection (SQLi) blocking rule
  rule {
    name     = "BlockSQLInjection"
    priority = 1
    action {
      block {}
    }
    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesSQLiRuleSet"  # AWS managed rule group for SQLi protection
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "SQLiBlockedRequests"
      sampled_requests_enabled   = true
    }
  }

  # Cross-Site Scripting (XSS) blocking rule
  rule {
    name     = "BlockXSS"
    priority = 2
    action {
      block {}
    }
    statement {
      managed_rule_group_statement {
        vendor_name = "AWS"
        name        = "AWSManagedRulesXSSRuleSet"  # AWS managed rule group for XSS protection
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "XSSBlockedRequests"
      sampled_requests_enabled   = true
    }
  }

  # GeoMatch rule to allow only US traffic
  rule {
    name     = "AllowUSOnly"
    priority = 3
    action {
      allow {}
    }
    statement {
      geo_match_statement {
        country_codes = ["US"]  # Only allow requests from the United States (US)
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "USAllowedRequests"
      sampled_requests_enabled   = true
    }
  }

  # Rule to block all non-US traffic
  rule {
    name     = "BlockNonUS"
    priority = 4
    action {
      block {}
    }
    statement {
      not_statement {
        statement {
          geo_match_statement {
            country_codes = ["US"]  # Block traffic that is not from the US
          }
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "NonUSBlockedRequests"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WebAclMetrics"
    sampled_requests_enabled   = true
  }
}
