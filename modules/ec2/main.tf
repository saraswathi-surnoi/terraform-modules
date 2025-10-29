resource "aws_instance" "ec2" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
#   key_name      = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids

  user_data = var.user_data

  tags = merge(
    var.tags,
    {
      Name = var.instance_names[count.index]
    }
  )
}

