/*
resource "ciscomcd_service_vpc" "aws_service_vpc" {
  name               = var.ciscomcd_svpc_name
  csp_account_name   = var.aws_account_name
  region             = var.region
  cidr               = var.vpc_cidr
  availability_zones = var.zones
  transit_gateway_id = aws_ec2_transit_gateway.ciscomcd_tgw.id
  use_nat_gateway    = var.ciscomcd_svpc_use_nat_gateway
}
*/