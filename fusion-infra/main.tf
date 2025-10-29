module "key_pair" {
  source        = "../modules/key-pair"
  key_pair_name = "${var.project_name}-key"
}

module "security_group" {
  source       = "../modules/sg"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = var.sg_name
  vpc_id       = data.aws_vpc.default.id    # ✅ FIXED HERE

  common_tags = var.common_tags
  sg_tags = {
    Purpose = "allow-tls"
    Managed = "terraform"
  }
}

module "ec2" {
  source                 = "../modules/ec2"
  ami                    = data.aws_ami.ubuntu_surnoi.id
  instance_names         = var.instance_names
  instance_type          = var.instance_type
  instance_count         = var.instance_count
  key_name               = module.key_pair.key_pair_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  user_data              = file("${path.module}/user_data.sh")

  tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}