terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    ciscomcd = {
      source  = "CiscoDevNet/ciscomcd"
      version = "0.2.9"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "ciscomcd" {
  api_key_file = file(var.ciscomcd_api_key_file)
}