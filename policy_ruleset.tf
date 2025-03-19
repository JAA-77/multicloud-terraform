/*  Las Policy Rule Set no se deben crear sino lear del CSC

resource "ciscomcd_policy_rule_set" "ingress_policy" {
  name = var.ciscomcd_ingress_policy_rule_set_name
}


resource "ciscomcd_policy_rule_set" "egress_policy" {
  name = var.ciscomcd_egress_policy_rule_set_name
}
*/


/* Exportado de AWS CloudShell

  # ciscomcd_policy_rule_set.egressew_policy will be created
  + resource "ciscomcd_policy_rule_set" "egressew_policy" {
      + id          = (known after apply)
      + name        = "mcd-egress-ruleset-allow-all"
      + rule_set_id = (known after apply)
    }

  # ciscomcd_policy_rule_set.ingress_policy will be created
  + resource "ciscomcd_policy_rule_set" "ingress_policy" {
      + id          = (known after apply)
      + name        = "mcd-ingress-ruleset-allow-all"
      + rule_set_id = (known after apply)
    }

*/
