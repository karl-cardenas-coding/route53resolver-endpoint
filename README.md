#### Route53Resolver Endpoint

This module creates a route53 resolver endpoint. The module leverages the aws cli, so it's important you have the aws cli `~/.aws/config` populated. Note: This module does not create the route53 resolver rule required to associate an endpoint to outbound VPC traffic.


##### Inputs
| Name | Description | Default | Type |Required |
|------|-------------|:-----:|:-----:|:-----:|
| direction| The direction of the resolver endpoint | - | string | yes |
| subnet-ids|The subnet ids for the endpoint to be applied to| - | list | yes |
| security-groups| The security groups to be applied | - | list | yes |
| ip-addresses| The ip address for the endpoins to leverage, 1 per subnet | - | list | yes |
| endpoint-name| The name of the endpoint | - | string | yes |
| aws-profile| The aws profile name to use | - | string | yes |
| delete| This will delete the endpoint created | false | string | no |
| tags | The tags to apply for the endpoint | - | string | yes |





##### Outputs

| Name | Description |
|------|-------------|
|aws-cli-output| The aws cli output from the command|
|endpoint-id| The resolver endpoint ID|



Usage Example:
```terraform
module "route53resolver-endpoint" {
  direction       = "INBOUND"
  security-groups = "sg-123456789 sg-abcdefg"
  subnet-ids      = ["subnet-123456789asaf", "subnet-123456789asaf"]
  ip-addresses    = ["10.1.1.111", "10.1.2.111"]
  endpoint-name   = "terraform-testing"
  profile         = "test-env"
  tags            = "Key=Owner,Value=admin
}


output "cli-output" {
  value = "${module.route53resolver-endpoint.aws-cli-output}"
}

output "resolver-id" {
  value = "${module.route53resolver-endpoint.endpoint-id}"
}
```
