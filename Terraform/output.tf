output "frontend_public_ip" {
  description = "Public IP of the web server EC2 instance"
  value       = aws_instance.frontend.public_ip
}

output "backend_private_ip" {
  description = "Private IP of the application server EC2 instance"
  value       = aws_instance.backend.private_ip
}

output "rds_endpoint" {
  description = "Endpoint of the MySQL RDS instance"
  value       = aws_db_instance.mysql_db.endpoint
}

output "ecr_repository_url" {
  description = "URL of the ECR repository for the application"
  value       = aws_ecr_repository.app_repo.repository_url
  
}
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app_alb.dns_name
}