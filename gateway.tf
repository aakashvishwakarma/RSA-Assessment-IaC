resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ceq_vpc.id
  tags = merge(local.common_tags,
    tomap({"Name"= "${var.platform_name}-${var.application_name}-${var.environment}-igw"
    })
  )

  depends_on = [aws_vpc.ceq_vpc]
}

resource "aws_eip" "web_eip" {
  vpc = true
  tags = merge(local.common_tags,
    tomap({"Name" ="${var.platform_name}-${var.application_name}-${var.environment}-web-eip"
    })
  )
}

resource "aws_nat_gateway" "web_natgw" {
  allocation_id = aws_eip.web_eip.id
  subnet_id     = aws_subnet.web_public_subnets[0].id
  tags = merge(local.common_tags,
    tomap({"Name"= "${var.platform_name}-${var.application_name}-${var.environment}-web-natgw"
    })
  )
  depends_on = [aws_eip.web_eip, aws_subnet.web_public_subnets]

}


resource "aws_eip" "rds_eip" {
  vpc = true
  tags = merge(local.common_tags,
    tomap({"Name"="${var.platform_name}-${var.application_name}-${var.environment}-rds-eip"
    })
  )
}

resource "aws_nat_gateway" "rds_natgw" {
  allocation_id = aws_eip.rds_eip.id
  subnet_id     = aws_subnet.web_public_subnets[1].id
  tags = merge(local.common_tags,
    tomap({"Name"= "${var.platform_name}-${var.application_name}-${var.environment}-rds-natgw"
    })
  )
  depends_on = [aws_eip.rds_eip, aws_subnet.web_public_subnets]

}
