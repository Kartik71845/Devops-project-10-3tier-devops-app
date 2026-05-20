resource "aws_vpc_endpoint" "ssm_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.private.id, aws_subnet.private_2.id]
  security_group_ids = [aws_security_group.ssm_sg.id]

  tags = {
    Name        = "ssm-endpoint"
    Environment = "dev"
    Project     = "aws-3tier"
  }
}

resource "aws_vpc_endpoint" "ec2_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.private.id, aws_subnet.private_2.id]
  security_group_ids = [aws_security_group.ssm_sg.id]

  tags = {
    Name        = "ec2-endpoint"
    Environment = "dev"
    Project     = "aws-3tier"
  }
}

resource "aws_vpc_endpoint" "ssm_messages_endpoint" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [aws_subnet.private.id, aws_subnet.private_2.id]
  security_group_ids = [aws_security_group.ssm_sg.id]

  tags = {
    Name        = "ssm-messages-endpoint"
    Environment = "dev"
    Project     = "aws-3tier"
  }
  
}