# resource "aws_key_pair" "tf_key" {
#   key_name   = "terraform-key-new"
#   public_key = file("terraform-key-new.pub")
#   tags = {
#     Name        = "terraform-key-new"
#     Environment = "dev"
#     Project = "aws-3tier"
#   }
# }

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "tf-ec2-instance-profile"
  role = "ecr"
}
resource "aws_instance" "frontend" {                     # Web Server EC2 
  ami                         = "ami-091138d0f0d41ff90" # ubuntu server in us-east-1
  instance_type               = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = "brian"
  user_data = (file("userdata.sh"))

  tags = {
    Name        = "front-end-ec2"
    Environment = "dev"
    Project = "aws-3tier"
  }
}

resource "aws_iam_instance_profile" "ec2_instance_ssm_profile" {
  name = "tf-ssm"
  role = "ssm"
}
resource "aws_instance" "backend" {                     # Application Server EC2
  ami                         = "ami-091138d0f0d41ff90" # ubuntu server in us-east-1
  instance_type               = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_ssm_profile.name
  subnet_id                   = aws_subnet.private.id
  vpc_security_group_ids      = [aws_security_group.app_sg.id]
  associate_public_ip_address = false
  key_name                    = "brian"
  user_data = file("userdata.sh")

  tags = {
    Name        = "backend-ec2"
    Environment = "dev"
    Project = "aws-3tier"
  }
}