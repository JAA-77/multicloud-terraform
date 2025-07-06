/* Testing only visibility

resource "ciscomcd_service_vpc" "aws_service_vpc" {
  name               = var.ciscomcd_svpc_name
  csp_account_name   = var.aws_account_name
  region             = var.region
  cidr               = var.vpc_cidr
  availability_zones = var.zones
  transit_gateway_id = aws_ec2_transit_gateway.ciscomcd_tgw.id
  use_nat_gateway    = var.ciscomcd_svpc_use_nat_gateway
}

Testing only visibility */


/* Exportado de CSC
resource "ciscomcd_service_vpc" "inspection-vpc" {
	name = "inspection-vpc"
	csp_account_name = "AWS_CiscoU_Test_Acct"
	region = "eu-west-1"
	cidr = "10.20.30.0/24"
	availability_zones = ["eu-west-1a"]
	use_nat_gateway = false
	transit_gateway_id = "tgw-06d0e46d4fbee71aa"
}
*/

/* Exportado de AWS CloudShell

      + availability_zones     = ["eu-west-1a"]
      + cidr                   = "10.20.30.0/24"
      + csp_account_name       = "AWS_CiscoU_Test_Acct"
      + id                     = (known after apply)
      + management_vpc_id      = (known after apply)
      + name                   = "inspection-vpc"
      + nat_gateway_public_ips = (known after apply)
      + region                 = "eu-west-1"
      + service_vpc_id         = (known after apply)
      + transit_gateway_id     = (known after apply)
      + use_nat_gateway        = false
      + vpc_id                 = (known after apply)

*/