variable "creator-request-id" {
  type = "string"
  description = "Name to identify the request"
}

variable "direction" {
  type = "string"
  description = "INBOUND OR OUTBOUND"
}

variable "subnet-ids" {
  type = "list"
  description = "The ID of subnets that contain the IP addresess"
}

variable "security-groups" {
  type = "list"
  description = "The ID of security groups that you want to use to control access to this VPC"
}

variable "ip_addresses" {
  type = "list"
  description = "The IP addresses to apply"
}

variable "endpoint-name" {
  type = "string"
  description = "A name for your endpoint"
}

variable "aws-profile" {
  type = "string"
  description = "The AWS profile as found in the ~/.aws/config file"
}

variable "tags" {
  type = "string"
}

variable "delete" {
  type = "string"
  default = "false"
  description = "Used to delete the the endpoint"
}
