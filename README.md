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
