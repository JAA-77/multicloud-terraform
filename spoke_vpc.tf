
resource "ciscomcd_spoke_vpc" "ciscomcd_spoke_defender" {
  service_vpc_id                     = ciscomcd_service_vpc.aws_service_vpc.id
  spoke_vpc_id                       = aws_vpc.defender_vpc.id
  transit_gateway_attachment_subnets = [aws_subnet.defender_subnet_pub.id]
}

resource "ciscomcd_spoke_vpc" "ciscomcd_spoke_attacker" {
  service_vpc_id                     = ciscomcd_service_vpc.aws_service_vpc.id
  spoke_vpc_id                       = aws_vpc.attacker_vpc.id
  transit_gateway_attachment_subnets = [aws_subnet.attacker_subnet_pub.id]
}


/* I don't know how to set the values on spoke_vpcs so I have splitted the for statement

var.spoke_vpcs = {
  "attacker" = {
    spoke_vpc_id = aws_vpc.attacker_vpc.id
    spoke_vpc_subnets = [aws_vpc.attacker_subnet_pub.id]
  },
  "defender" = {
    spoke_vpc_id = aws_vpc.defender_vpc.id
    spoke_vpc_subnets = [aws_vpc.defender_subnet_pub.id]
  }
}

resource "ciscomcd_spoke_vpc" "ciscomcd_spoke" {
  for_each                           = var.spoke_vpcs
  service_vpc_id                     = ciscomcd_service_vpc.aws_service_vpc.id
  spoke_vpc_id                       = each.value.spoke_vpc_id
  transit_gateway_attachment_subnets = each.value.spoke_vpc_subnets
}

*/
