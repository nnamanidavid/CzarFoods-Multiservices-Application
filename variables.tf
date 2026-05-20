variable "region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.123.0.0/16"
}

variable "default_tags" {
  description = "Default tags to apply to all resources."
  type        = map(string)
  default     = {
    Project     = "CzarFoods"
    Environment = "Test"
    }
}

variable "public_subnet_count" {
  description = "Number of public subnets to create."
  type        = number
  default     = 2
}

variable "private_subnet_count" {
  description = "Number of private subnets to create."
  type        = number
  default     = 2
}

variable "DB_private_ip" {
  type        = string
  description = "Private IP address for the RDS instance."
}

variable "instance_key_name" {
  type = string
  description = "Name of the EC2 key pair to use for SSH access."
}

variable "database_service_name" {
  type = string
  description = "Database service name"
  default = "database"
}

variable "database_message" {
  type = string
  description = "Database message"
  default = "Hello from Yuuci's Database"
}