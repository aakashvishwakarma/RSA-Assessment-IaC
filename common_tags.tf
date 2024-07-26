locals {
  common_tags = {
    Terraform   = "true"
    Environment = var.environment
    Owner       = var.owner
    Account     = var.account
    ApplicationID = var.app_id
  }
}
