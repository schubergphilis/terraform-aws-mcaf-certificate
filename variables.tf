variable "common_name" {
  type        = string
  description = "Certificate common name"
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "List of Subject Alternative Names (SANs) to include in the certificate"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to add to resources"
  default     = null
}

variable "zone_id" {
  type        = string
  description = "Route53 Zone ID to create validation records in"
}
