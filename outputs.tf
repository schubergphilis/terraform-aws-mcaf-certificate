output "arn" {
  description = "Certificate ARN"
  value       = aws_acm_certificate.default.arn
}

output "id" {
  description = "Certificate ID"
  value       = aws_acm_certificate.default.id
}
