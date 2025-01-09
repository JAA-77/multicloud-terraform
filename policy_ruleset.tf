resource "ciscomcd_policy_rule_set" "ingress_policy" {
  name = var.ciscomcd_ingress_policy_rule_set_name
}


resource "ciscomcd_policy_rule_set" "egressew_policy" {
  name = var.ciscomcd_egress_policy_rule_set_name
}