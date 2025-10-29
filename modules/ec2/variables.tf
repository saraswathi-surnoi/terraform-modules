variable "ami" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_names" {
  description = "List of instance names"
  type        = list(string)
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of Security Group IDs"
  type        = list(string)
}

variable "tags" {
  description = "Tags to assign to EC2 instances"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data script for instance initialization"
  type        = string
  default     = ""
}
