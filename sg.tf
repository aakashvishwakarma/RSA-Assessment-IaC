# A security group must be set up and assign VPC to allow both inbound and outbound traffic. 
# We must set up 4 types of security groups i.e private, public  and rds security groups.

resource "aws_security_group" "ec2_public_security_group" {
  name        = "EC2-public-scg"
  description = "Internet reaching access for public ec2s"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = ["YOUR_IP_ADDRESS/32"]

  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["YOUR_IP_ADDRESS/32"]
  }


  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags,
    tomap({"Name"= "${var.platform_name}-${var.application_name}-${var.environment}-ec2_public_sg"
    })
  )

  depends_on = [aws_vpc.my_vpc]
}



resource "aws_security_group" "ec2_private_security_group" {
  name        = "EC2-private-scg"
  description = "Only allow public SG resources to access private instances"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_public_security_group.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.ec2_public_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags,
    tomap({"Name"= "${var.platform_name}-${var.application_name}-${var.environment}-ec2_private_sg"
    })
  )

  depends_on = [aws_vpc.my_vpc, aws_security_group.ec2_public_security_group]
}


resource "aws_security_group" "db_security_groups" {
  name        = "db-sg"
  description = "Database Security Group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 5432
    protocol    = "tcp"
    to_port     = 5432
    security_groups = [aws_security_group.ec2_private_security_group.id]
    description = "Allow access to RDS from app servers"
  } 

  tags = merge(local.common_tags,
    tomap({"Name"= "${var.platform_name}-${var.application_name}-${var.environment}-db_sg"
    })
  )
}

