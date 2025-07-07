
variable "ciscomcd_api_key_file" {
  type = string  
  default = "./mcd_api_key.json"
}

variable "aws_key_pair" {
  type = string
  default = "mcd-demo"
}

variable "aws_account_name" {
  type = string
  default = "AWS_CiscoU_Test_Acct"
}

variable "zones" {
  description = "List of Availability Zone names where the ciscomcd Gateway instances are deployed"
  default     = ["eu-west-1a"]
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
  description = "AWS region where Service VPC (and ciscomcd Gateways) are deployed. Required when running as root module"
  default     = "eu-west-1"
}

/*
variable "gateway_image" {
  type = string
}
*/
variable "ciscomcd_egress_policy_rule_set_name" {
  type    = string
  default = "ciscomcd-egress-ruleset-allow-all"  // Aqui va el nombre de la politica de filtrado configurada en MCD que se quiere asociar al nuevo TGW
}

variable "ciscomcd_ingress_policy_rule_set_name" {
  type    = string
  default = "ciscomcd-ingress-ruleset-allow-all"  // Aqui va el nombre de la politica de filtrado configurada en MCD que se quiere asociar al nuevo TGW
}

variable "ciscomcd_egress_gateway_autoscale_min" {
  type    = string
  default = 1
}

variable "ciscomcd_egress_gateway_autoscale_max" {
  type    = string
  default = 3
}

variable "ciscomcd_svpc_name" {
  type    = string
  default = "inspection-vpc-terraformed"
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

variable "proyecto" {
  type    = string
  default = "PoC de Cisco MultiCloud Defense"
}

variable "spoke_vpcs" {
  type = list(string)
  default = [aws_vpc.defender_vpc.id,aws_vpc.attacker_igwder_vpc.id]
}
