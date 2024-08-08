data "aws_route53_zone" "selected" {
  name = "myzone.com."
}

# To create a certificate in an account that also hosts the Route53 zone for validation:
provider "aws" {}

module "certificate_with_zone_in_account" {
  source = "../.."

  providers = { aws.route53 = aws }

  common_name = "www.myzone.com"
  zone_id     = data.aws_route53_zone.selected.zone_id
}

# To create a certificate in an account that does not host the Route53 zone for validation, an
# aliased provider can be used to create the validation records:
provider "aws" {
  alias = "route53"
}

module "certificate_with_zone_in_remote_account" {
  source = "../.."

  providers = { aws.route53 = aws.route53 }

  common_name = "www.myzone.com"
  zone_id     = data.aws_route53_zone.selected.zone_id
}
