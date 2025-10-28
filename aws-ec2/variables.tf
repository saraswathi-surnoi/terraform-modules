variable "instance_type" {
    default = "t3.micro"
    type        = string
    # validation {
    #     condition     = contains(["t3.micro", "t3.medium", "t3.small"], var.instance_type)
    #     error_message = "instance_type can only be one of t3.micro, t3.medium, t3.small"
    # } 
}
variable "instance_count" {
  type        = number
  default     = 3
  description = "Number of EC2 instances to create"
}
variable "instance_names" {
  type = list(string)
  default = ["backend-1", "backend-2", "jenkins-master"]
  description = "List of instance names"
}