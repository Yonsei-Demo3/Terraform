variable "project_name" {
    description = "The name of the project to prefix resource names"
    type        = string
    default     = "sai_project"
}

variable "bucket_name" {
    description = "The name of the S3 bucket, unique across all AWS users"
    type        = string
}

variable "environment" {
    description = "The deployment environment (e.g., dev, staging, prod)"
    type        = string
    default     = "dev"
}

variable "ec2_iam_role_arn" {
    description = "The ARN of the IAM role for the EC2 instance"
    type        = string
}