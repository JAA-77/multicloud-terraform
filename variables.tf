
variable "ciscomcd_api_key_file" {
  type = string  
  default = "./mcd_api_key.json"
}

variable "aws_account_name" {
  type = string
  default = "AWS_CiscoU_Test_Acct"
}

variable "zones" {
  description = "List of Availability Zone names where the ciscomcd Gateway instances are deployed"
  default     = ["us-east-1a"]
}
/*
variable "prefix" {
  description = "Prefix for the resources (vpc, subnet, route tables)"
  default     = "ciscomcd_svpc"
}
*/
variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.20.30.0/24"
}
/*
variable "vpc_subnet_bits" {
  description = "Number of additional bits in the subnet. The final subnet mask is the vpc_cidr mask + the value provided here"
  default     = 8
}
*/

variable "region" {
  description = "(Optional) AWS region where Service VPC (and ciscomcd Gateways) are deployed. Required when running as root module"
  default     = "us-east-1"
}

/*
variable "gateway_image" {
  type = string
}

variable "ciscomcd_egress_policy_rule_set_name" {
  type    = string
  default = "eg-policy"
}

variable "ciscomcd_ingress_policy_rule_set_name" {
  type    = string
  default = "in-policy"
}

variable "ciscomcd_egress_gateway_autoscale_min" {
  type    = string
  default = 1
}

variable "ciscomcd_egress_gateway_autoscale_max" {
  type    = string
  default = 3
}
*/
variable "ciscomcd_svpc_name" {
  type    = string
  default = "inspection-vpc"
}
/*
# variable "aws_tgw_id" {
#   type = string
# }
*/
variable "ciscomcd_svpc_use_nat_gateway" {
  type    = bool
  default = false
}
/*
variable "spoke_vpcs" {
}
*/