/*

resource "ciscomcd_spoke_vpc" "ciscomcd_spoke" {
  for_each                           = var.spoke_vpcs
  service_vpc_id                     = ciscomcd_service_vpc.aws_service_vpc.id
  spoke_vpc_id                       = each.value.spoke_vpc_id
  transit_gateway_attachment_subnets = each.value.spoke_vpc_subnets
}

*/