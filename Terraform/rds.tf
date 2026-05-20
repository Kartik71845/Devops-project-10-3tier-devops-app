resource "aws_db_subnet_group" "db_subnet_group" { # db subnet group
  name       = "tf-db-subnet-group"
  subnet_ids = [aws_subnet.private.id, aws_subnet.private_2.id]

  tags = {
    Name        = "tf-db-subnet-group"
    Environment = "dev"
    Project = "aws-3tier"
  }

}

resource "aws_db_instance" "mysql_db" { # mysql rds instance
  identifier             = "tf-mysql-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "appdatabase"
  username               = "kartik"
  password               = "Kartik9*#"
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name        = "tf-mysql-db"
    Environment = "dev"
    Project = "aws-3tier"
  }
}