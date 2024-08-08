output "arn" {
  description = "Certificate ARN"
  value       = aws_acm_certificate.default.arn
}

output "domain_name" {
  description = "Domain name for which the certificate is issued"
  value       = aws_acm_certificate.default.domain_name
}

output "id" {
  description = "Certificate ID"
  value       = aws_acm_certificate.default.id
}

output "not_after" {
  description = "Expiration date and time of the certificate"
  value       = aws_acm_certificate.default.not_after
}

output "not_before" {
  description = "Start of the validity period of the certificate"
  value       = aws_acm_certificate.default.not_before
}

output "status" {
  description = "Status of the certificate"
  value       = aws_acm_certificate.default.status
}
