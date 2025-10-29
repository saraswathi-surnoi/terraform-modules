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


# variable "instance_names" {
#   type    = list(string)
#   default = ["backend-1", "backend-2", "jenkins-master"]
# }

# variable "instance_type" {
#   default = "t3.micro"
# }

variable "jenkins_instance_count" {
  type        = number
  default     = 1
  description = "Number of Jenkins master instances to launch"
}

variable "backend_instance_count" {
  type        = number
  default     = 2
  description = "Number of backend instances to launch"
}


variable "common_tags" {
  default = {
    Owner      = "Saraswathi"
    Department = "DevOps"
  }
}
variable "instance_types" {
  type = object({
    jenkins = string
    backend = string
  })
  default = {
    jenkins = "t3.small"
    backend = "t3.micro"
  }
}
variable "instance_names" {
  description = "Map of instance names for different servers"
  type = object({
    jenkins = list(string)
    backend = list(string)
  })
  default = {
    jenkins = ["jenkins-master"]
    backend = ["backend-1", "backend-2"]
  }
}



