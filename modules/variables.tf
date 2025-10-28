variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type for EC2"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to create"
}

variable "instance_names" {
  type        = list(string)
  description = "List of instance names"
  default = ["backend-1", "backend-2", "jenkins-master"]
}
variable "security_group_ids" {
    type = list(string)
}
variable "project_name" {
  description = "Project name"
  type        = string
  default     = "fusioniq"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "sg_name" {
  description = "Security group name"
  type        = string
  default     = "backend-sg"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0abcd1234efgh5678"
}

variable "common_tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Owner       = "Saraswathi"
    Application = "fusion"
    ManagedBy   = "Terraform"
  }
}

