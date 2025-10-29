resource "aws_security_group" "main" {
  name        = local.sg_final_name
  description = "Allow inbound SSH (22), HTTPS (443), and App traffic (8080). Allow all outbound."
  vpc_id      = var.vpc_id

dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description = "Allow TCP traffic on port ${ingress.value}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ingress.value == 22 ? [var.my_ip_cidr] : ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    var.sg_tags,
    {
      Name        = local.sg_final_name
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}
