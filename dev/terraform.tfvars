###################Account Details and Tags#############################################
platform_name            = "aws"
environment              = "dev"
account                  = "devops"
application_name         = "rsa-asssessment"
owner                    = "aakash"
app_id                   = "rsa-assessment"
region                   = "us-east-1"


####################VPC, Public Subnets, Private Subnets###########################################################
vpc_cidr                 	= "10.0.0.0/16"
vpc_cidr_ss              	= "10.0.0.0/16"
availability_zone        	= ["us-east-1a","us-east-1b"]
web_public_subnet_names  	= ["web_subnet_1a","web_subnet_1b"]
app_private_subnet_names    = ["app_subnet_1a","app_subnet_1b"]
rds_private_subnet_names    = ["rds_subnet_1a","rds_subnet_1b"]
web_public_subnet_cidr   	= ["10.0.0.0/24","10.0.1.0/24"]
app_private_subnet_cidr     = ["10.0.2.0/24","10.0.3.0/24"]
rds_private_subnet_cidr     = ["10.0.4.0/24","10.0.5.0/24"]
web_servers_count           = 2
app_servers_count		    = 2
