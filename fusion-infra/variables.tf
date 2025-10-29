variable "project_name" {
  default = "fusion"
}

variable "environment" {
  default = "dev"
}

variable "sg_name" {
  default = "fusion-sg"
}

# variable "vpc_id" {
#   description = "VPC ID where EC2 and SG will be created"
# }

variable "instance_names" {
  type    = list(string)
  default = ["backend-1", "backend-2", "jenkins-master"]
}

variable "instance_type" {
  default = "t3.micro"
}

variable "instance_count" {
  default = 3
}

variable "common_tags" {
  default = {
    Owner      = "Saraswathi"
    Department = "DevOps"
  }
}