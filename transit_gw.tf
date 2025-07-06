/* Testing only visibility

resource "aws_ec2_transit_gateway" "ciscomcd_tgw" {
  description = "ciscomcd_tgw_terraformed"
  default_route_table_association    = "disable"
  default_route_table_propagation    = "disable"
  tags = {
    proyecto = var.proyecto
  }
}

Testing only visibility */


/* Exportado de AWS CloudShell

      + amazon_side_asn                    = 64512
      + arn                                = (known after apply)
      + association_default_route_table_id = (known after apply)
      + auto_accept_shared_attachments     = "disable"
      + default_route_table_association    = "enable"
      + default_route_table_propagation    = "enable"
      + description                        = "ciscomcd_tgw"
      + dns_support                        = "enable"
      + id                                 = (known after apply)
      + multicast_support                  = "disable"
      + owner_id                           = (known after apply)
      + propagation_default_route_table_id = (known after apply)
      + security_group_referencing_support = "disable"
      + tags_all                           = (known after apply)
      + vpn_ecmp_support                   = "enable"

*/

