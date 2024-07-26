# General Variables
variable platform_name {}
variable "environment" {}
variable "account" {}
variable "application_name" {}
variable "app_id" {}

variable "owner" {}
variable "region" {}
variable "deployment_role_arn" {}
variable "enable_deletion_protection" {
  default = true
}


######################################################################
#VPC,Security groups, subnets
variable "vpc_cidr" {}
variable "vpc_cidr_ss" {}


variable "web_public_subnet_names" {
  type = list
}

variable "app_private_subnet_names" {
  type = list
}

variable "rds_private_subnet_names" {
  type = list
}

variable "web_public_subnet_cidr" {
  type = list
}
variable "app_private_subnet_cidr" {
  type = list
}
variable "rds_private_subnet_cidr" {
  type = list
}

variable "availability_zone" {
  type = list
}
