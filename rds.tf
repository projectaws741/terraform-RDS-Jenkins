resource "aws_db_instance" "postgres" {
  # Basic Configuration
  allocated_storage      = 20 # Storage in GB (adjust as per need)
  max_allocated_storage  = 30 # Allow auto-scaling up to this limit
  db_name =                 "proddb123"
  engine                 = "postgres"
  engine_version         = "16.3" # Adjust as per your requirement
  instance_class         = "db.t4g.micro" # Production instance type
#   name                   = "production_db" # Database name
  username               = "krishna" # Master username
  password               = "KrishnaKittu123" # Strong password (use secrets manager)
#   parameter_group_name   = "default.postgres15" # Default parameter group for the version
  publicly_accessible    = true
  availability_zone = "us-east-1a"
  skip_final_snapshot = true


  # High Availability and Multi-AZ
#   multi_az               = true

#   # Storage Encryption
#   storage_encrypted      = true
#   kms_key_id             = "your-kms-key-id" # Optional: If you have a custom KMS key

  # Backup and Maintenance
  backup_retention_period = 7 # Retain backups for 7 days
  backup_window           = "03:00-04:00" # Backup window in UTC
  maintenance_window      = "Mon:04:00-Mon:05:00" # Maintenance window in UTC

  # Monitoring
#   monitoring_interval     = 60 # Enable enhanced monitoring at 60-second intervals
#   monitoring_role_arn     = "arn:aws:iam::your-account-id:role/rds-monitoring-role" # Replace with your role

  # Subnet Group
#   db_subnet_group_name = "default"

  # Security Group
  vpc_security_group_ids = ["sg-028f5efba0fd6606f"]

  # Tags
  tags = {
    Environment = "production"
    Project     = "example-project"

  }
}

# resource "aws_db_subnet_group" "prod_subnet_group" {
#   name       = "prod-rds-subnet-group"
#   subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id] # Replace with your subnet IDs
#
#   tags = {
#     Name        = "prod-rds-subnet-group"
#     Environment = "production"
#   }
# }

# resource "aws_security_group" "db_security_group" {
#   name_prefix = "prod-db-sg-"
#   description = "Allow database access"
#   vpc_id      = "your-vpc-id" # Replace with your VPC ID
#
#   ingress {
#     from_port   = 5432 # PostgreSQL default port
#     to_port     = 5432
#     protocol    = "tcp"
#     cidr_blocks = ["10.0.0.0/16"] # Replace with your CIDR block or restrict further
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1" # All protocols
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   tags = {
#     Name        = "prod-db-security-group"
#     Environment = "production"
#   }
# }

# resource "aws_iam_role" "rds_monitoring_role" {
#   name = "rds-monitoring-role"
#
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "rds.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }
#
# resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
#   role       = aws_iam_role.rds_monitoring_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
# }

resource "aws_ssm_parameter" "db_endpoint" {
  name = "RDS_ENDPOINT"
  type = "String"
  value = replace(aws_db_instance.postgres.endpoint, "/:\\d+$/", "")
}
resource "aws_ssm_parameter" "db_username" {
  name = "RDS_USERNAME"
  type = "String"
  value = aws_db_instance.postgres.username
}
resource "aws_ssm_parameter" "db_password" {
  name = "RDS_PASSWORD"
  type = "SecureString"
  value = aws_db_instance.postgres.password
}
