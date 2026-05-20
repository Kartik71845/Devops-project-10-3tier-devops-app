Habit Tracker - 3 Tier DevOps Project
Project Overview

![alt text](<Untitled (11).gif>)

This project demonstrates a production-style 3-tier application deployment on AWS using Terraform, Docker, GitHub Actions, ECR, ALB, EC2, and RDS.

The primary goal of this project was to understand:

Infrastructure provisioning using Terraform
Containerization using Docker
CI/CD automation using GitHub Actions
Load balancing using AWS ALB
Path-based routing
Docker image deployment using AWS ECR
Backend and database separation using private networking
Architecture
Application Layers
Frontend Layer
React application
Dockerized
Runs on EC2
Backend Layer
Node.js / Express API
Dockerized
Runs on EC2
Database Layer
AWS RDS MySQL
Traffic Flow
User
 ↓
Application Load Balancer (ALB)
 ├── "/" → Frontend EC2
 └── "/api/*" → Backend EC2
                           ↓
                          RDS
CI/CD Flow
Developer
 ↓
GitHub
 ↓
GitHub Actions
 ↓
Build Docker Images
 ↓
Push Images to AWS ECR
 ↓
EC2 Pulls Updated Images
 ↓
Containers Restart Automatically
AWS Services Used
AWS EC2
AWS ALB
AWS ECR
AWS RDS MySQL
AWS IAM
AWS CloudWatch
AWS VPC
Tools Used
Terraform
Docker
GitHub Actions
React
Node.js
Express
Features
Infrastructure as Code using Terraform
Dockerized frontend and backend
Automated CI/CD pipeline
Path-based routing using ALB
Private backend architecture
Docker image versioning
Health checks using ALB
CloudWatch monitoring
Automated container deployment
Path-Based Routing

The Application Load Balancer handles traffic routing:

Route	Destination
/	Frontend EC2
/api/*	Backend EC2
Docker Deployment

Frontend and backend applications are deployed as Docker containers.

GitHub Actions:

Builds Docker images
Pushes images to AWS ECR
Deploys updated containers on EC2
Terraform Infrastructure

Terraform provisions:

VPC
Public and Private Subnets
Route Tables
Internet Gateway
Security Groups
EC2 Instances
Application Load Balancer
Target Groups
RDS MySQL
IAM Roles
ECR Repository
Monitoring

CloudWatch was used for:

EC2 monitoring
ALB health monitoring
Container health checks
Health Checks

Backend health endpoint:

/api/health

ALB uses this endpoint to verify backend availability.

Deployment Strategy

Docker image versioning was managed using custom tags:

frontend-v1
backend-v1

New deployments replace existing containers automatically.

Future Improvements
Auto Scaling Groups (ASG)
HTTPS using ACM
Route53 integration
ECS/Fargate migration
Multi-AZ architecture
Centralized logging
Repository Structure
project/
│
├── frontend/
├── backend/
├── terraform/
├── .github/workflows/
└── README.md