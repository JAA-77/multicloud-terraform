

resource "ciscomcd_gateway" "aws_hub_gw1" {
  name                  = "aws-hub-gw1"
  description           = "AWS Gateway 1"
  csp_account_name      = var.aws_account_name
  instance_type         = "AWS_M5_LARGE"
  gateway_image         = var.gateway_image
  gateway_state         = "ACTIVE"
  mode                  = "HUB"
  security_type         = "EGRESS"
  policy_rule_set_id    = ciscomcd_policy_rule_set.egressew_policy.rule_set_id
  ssh_key_pair          = var.aws_key_pair
  aws_iam_role_firewall = "ciscomcd-gateway-role"
  region                = var.region
  vpc_id                = ciscomcd_service_vpc.aws_service_vpc.id
  min_instances         = var.ciscomcd_egress_gateway_autoscale_min
  max_instances         = var.ciscomcd_egress_gateway_autoscale_max
  #   log_profile            = ""
  #   packet_capture_profile = ""
  aws_gateway_lb = true
}

resource "ciscomcd_gateway" "aws_ingress_gw1" {
  name                  = "aws-ingress-gw1"
  description           = "AWS Ingress Gateway"
  csp_account_name      = var.aws_account_name
  instance_type         = "AWS_M5_LARGE"
  gateway_image         = var.gateway_image
  gateway_state         = "ACTIVE"
  mode                  = "HUB"
  security_type         = "INGRESS"
  policy_rule_set_id    = ciscomcd_policy_rule_set.ingress_policy.rule_set_id
  ssh_key_pair          = var.aws_key_pair
  aws_iam_role_firewall = "ciscomcd-gateway-role"
  region                = var.region
  vpc_id                = ciscomcd_service_vpc.aws_service_vpc.id
  min_instances         = var.ciscomcd_egress_gateway_autoscale_min
  max_instances         = var.ciscomcd_egress_gateway_autoscale_max
  #   log_profile            = ""
  #   packet_capture_profile = ""
}

