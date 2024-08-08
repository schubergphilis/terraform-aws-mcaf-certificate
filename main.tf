resource "aws_acm_certificate" "default" {
  domain_name               = var.common_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
  tags                      = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "default" {
  for_each = {
    for dvo in aws_acm_certificate.default.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  provider        = aws.route53
  name            = each.value.name
  allow_overwrite = true
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}
