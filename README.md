# terraform-aws-mcaf-certificate

Terraform module to manage certificates in AWS Certificate Manager.

## Usage

### DNS validation with Route 53

This module supports creating validation records in zones hosted in the same account as the certificate and for zones hosted in a different account. To support this use case, an additional provider needs to be passed to the module as shown below.

#### Creating a certificate using a local Route 53 zone for validation

```hcl
provider "aws" {}

data "aws_route53_zone" "selected" {
  name = "myzone.com."
}

module "certificate" {
  source  = "schubergphilis/mcaf-certificate/aws"

  providers = { aws.route53 = aws }

  common_name = "www.myzone.com"
  zone_id     = data.aws_route53_zone.selected.zone_id
}
```

#### Creating a certificate using a remote Route 53 zone for validation

```hcl
provider "aws" {}

provider "aws" {
  alias = "route53"
  // Configuration for the remote account
  // ...
}

data "aws_route53_zone" "selected" {
  name = "myzone.com."
}

module "certificate" {
  source  = "schubergphilis/mcaf-certificate/aws"

  providers = { aws.route53 = aws.route53 }

  common_name = "www.myzone.com"
  zone_id     = data.aws_route53_zone.selected.zone_id
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_aws.route53"></a> [aws.route53](#provider\_aws.route53) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_route53_record.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_name"></a> [common\_name](#input\_common\_name) | Certificate common name | `string` | n/a | yes |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 Zone ID to create validation records in | `string` | n/a | yes |
| <a name="input_subject_alternative_names"></a> [subject\_alternative\_names](#input\_subject\_alternative\_names) | List of Subject Alternative Names (SANs) to include in the certificate | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to add to resources | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Certificate ARN |
| <a name="output_domain_name"></a> [domain\_name](#output\_domain\_name) | Domain name for which the certificate is issued |
| <a name="output_id"></a> [id](#output\_id) | Certificate ID |
| <a name="output_not_after"></a> [not\_after](#output\_not\_after) | Expiration date and time of the certificate |
| <a name="output_not_before"></a> [not\_before](#output\_not\_before) | Start of the validity period of the certificate |
| <a name="output_status"></a> [status](#output\_status) | Status of the certificate |
<!-- END_TF_DOCS -->

## License

**Copyright:** Schuberg Philis

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
