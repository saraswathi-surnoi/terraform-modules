# ----------------- SECURITY GROUP -----------------
module "security_group" {
  source       = "../modules/sg"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = var.sg_name
  vpc_id       = data.aws_vpc.default.id

  common_tags = var.common_tags
  sg_tags = {
    Purpose = "allow-tls"
    Managed = "terraform"
  }
}

module "jenkins-master" {
  source                 = "../modules/ec2"
  ami                    = data.aws_ami.ubuntu_surnoi.id
  instance_names         = var.instance_names.jenkins
  instance_type          = var.instance_types.jenkins
  instance_count         = length(var.instance_names.jenkins)
  vpc_security_group_ids = [module.security_group.security_group_id]
  user_data              = file("${path.module}/user_jenkins.yml")

  tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "devops"
    }
  )
}

module "backend" {
  source                 = "../modules/ec2"
  ami                    = data.aws_ami.ubuntu_surnoi.id
  instance_names         = var.instance_names.backend
  instance_type          = var.instance_types.backend
  instance_count         = length(var.instance_names.backend)
  vpc_security_group_ids = [module.security_group.security_group_id]
  user_data              = file("${path.module}/user_backend.yml")

  tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "devops"
    }
  )
}
