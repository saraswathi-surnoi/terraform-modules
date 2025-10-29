variable "project_name" {
  default = "fusion"
}

variable "environment" {
  default = "dev"
}

variable "sg_name" {
  default = "fusion-sg"
}

variable "common_tags" {
  default = {
    Owner = "Saraswathi"
    Department = "DevOps"
  }
}

variable "sg_tags" {
  default = {}
}

variable "vpc_id" {
  description = "VPC ID where the SG will be created"
}

variable "allowed_ports" {
  type    = list(number)
  default = [22, 443, 8080]
}

# Optional: your IP for secure SSH access
variable "my_ip_cidr" {
  description = "Your public IP for SSH access"
  default     = "0.0.0.0/0" # replace with your IP like "49.206.xx.xx/32"
}
