module "ec2" {
  source             = "../terraform-aws-ec2"
  ami                = data.aws_ami.ubuntu_surnoi.id 
  instance_names     = var.instance_names
  instance_type      = var.instance_type
}
module "key_pair" {
  source        = "../key-pair"
  key_pair_name = "${var.project_name}-key"
}

module "security_group" {
  source       = "./modules/sg"

  project_name = var.project_name
  environment  = var.environment
  sg_name      = var.sg_name
  vpc_id       = var.vpc_id

  common_tags = var.common_tags
  sg_tags = {
    Purpose = "allow-tls"
    Managed = "terraform"
  }
}
