resource "aws_instance" "ec2" {
  count         = var.instance_count
  ami           = data.aws_ami.ubuntu_surnoi.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_names[count.index]
  }
}
