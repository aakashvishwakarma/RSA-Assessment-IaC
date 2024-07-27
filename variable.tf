# General Variables
variable platform_name {
  type = string
  description = "This is where you define the platform on which you want to deply, it comes under general tagging for compliance "
}
variable "environment" {
    type = string
  description = "This is where you define the environment(dev, prod, qa) on which you want to deply, it comes under general tagging "
}
variable "account" {
    type = string
  description = "This is the account name this is again for compliance purpose "
}
variable "application_name" {
  type = string
  description = "This is the  name of application this is again for compliance and to create the cost  budget and alarm by finOps "
}
variable "app_id" {
  type = string
  description = "This is the  name of application id this is again for compliance "
}

variable "owner" {
  type = string
  description = "This is the  name of of the person who own this project for visibility and compliance "
}
variable "region" {
  type = string
  description = "This is the  name of the region on which you want to deploy your infra "
}



######################################################################
#VPC,Security groups, subnets
variable "vpc_cidr" {
  type = string
  description = "This is the  cidr range of the VPC to be used "
}
variable "vpc_cidr_ss" {}


variable "web_public_subnet_names" {
  type = list
  description = "the list of names subnets for the front end web "
}

variable "app_private_subnet_names" {
  type = list
  description = "the list of names subnets for the backend app "
}

variable "rds_private_subnet_names" {
  type = list
  description = "the list of names subnets for the rds db "
}

variable "web_public_subnet_cidr" {
  type = list
  description = "the list of subnets cidr for the frontend "

}
variable "app_private_subnet_cidr" {
  type = list
  description = "the list of subnets cidr for the backend "
}
variable "rds_private_subnet_cidr" {
  type = list
  description = "the list of subnets cidr for the rds "
}

variable "availability_zone" {
  type = list
  description = "the list of azs for high availability  "
}
