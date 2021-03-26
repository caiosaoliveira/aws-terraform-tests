terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.34.0"
    }
  }

# AWS

provider "aws" {
  # Configuration options
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.aws_vpc_cidr
  
  tags = {
    Name = var.aws_vpc_name
  }
}

# Create a subnet
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.aws_subnet_cidr

  tags = {
    Name = var.aws_subnet_name
  }
}

# VMware Cloud on AWS

# provider "vmc" {
#   refresh_token = var.vmc_api_token
#   org_id = var.vmc_org_id
# }

# data "vmc_connected_accounts" "my_accounts" {
#   account_number = var.aws_account_number
# }

# data "vmc_customer_subnets" "my_subnets" {
#   connected_account_id = data.vmc_connected_accounts.my_accounts.id
#   region               = var.aws_region
# }

# resource "vmc_sddc" "sddc_1" {
#   sddc_name           = var.vmc_sddc_name
#   vpc_cidr            = var.vmc_sddc_cidr
#   num_host            = 3
#   provider_type       = "AWS"
#   region              = data.vmc_customer_subnets.my_subnets.region
#   delay_account_link  = false
#   skip_creating_vxlan = false
#   deployment_type     = "SingleAZ"
#   host_instance_type  = var.vmc_host_type

#   account_link_sddc_config {
#     customer_subnet_ids  = [data.vmc_customer_subnets.my_subnets.ids[0]]
#     connected_account_id = data.vmc_connected_accounts.my_accounts.id
#   }
#   microsoft_licensing_config {
#    mssql_licensing = "DISABLED"
#    windows_licensing = "DISABLED"
#   }
# }