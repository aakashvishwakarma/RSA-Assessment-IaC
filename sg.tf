# A security group must be set up and assign VPC to allow both inbound and outbound traffic. 
# We must set up 4 types of security groups i.e  Web ALB, App ALB, private, and public security groups.

resource "aws_security_group" "web_alb_security_group" {
  name        = "Web-ALB-SG"
  description = "Web ALB Security Group - Allow external web traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow web traffic to load balancer"
  }

  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 9080
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow web traffic to load balancer"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags,
    tomap({"Name"="${var.platform_name}-${var.application_name}-${var.environment}-web_alb_sg"
    })
  )
}


resource "aws_security_group" "ec2_public_security_group" {
  name        = "EC2-public-scg"
  description = "Internet reaching access for public ec2s"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.web_alb_security_group.id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_alb_security_group.id]
  }

  ingress {
    from_port       = 8080
    to_port         = 9080
    protocol        = "tcp"
    security_groups = [aws_security_group.web_alb_security_group.id]
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

  depends_on = [aws_vpc.my_vpc, aws_security_group.web_alb_security_group]
}

resource "aws_security_group" "app_alb_security_group" {
  name        = "App-ALB-SG"
  description = "App ALB Security Group - Allow traffic from web ec2"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 80
    protocol        = "tcp"
    to_port         = 80
    security_groups = [aws_security_group.ec2_public_security_group.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_public_security_group.id]
  }

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_public_security_group.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags,
    tomap({"Name"= "${var.platform_name}-${var.application_name}-${var.environment}-app_alb_sg"
    })
  )
}

resource "aws_security_group" "ec2_private_security_group" {
  name        = "EC2-private-scg"
  description = "Only allow public SG resources to access private instances"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.app_alb_security_group.id]
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

  depends_on = [aws_vpc.my_vpc, aws_security_group.app_alb_security_group]
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

