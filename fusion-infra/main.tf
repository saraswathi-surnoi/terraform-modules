
module "sg_backend" {
  source       = "../modules/sg"
  project_name = var.project_name
  environment  = var.environment
  sg_name      = "${var.project_name}-backend-sg"

  vpc_id       = data.aws_vpc.default.id
  common_tags  = var.common_tags
  allowed_ports = var.backend_ports

  sg_tags = {
    Purpose = "backend-traffic"
    Managed = "terraform"
  }
}


module "sg_jenkins" {
  source       = "../modules/sg"
  project_name = var.project_name
  environment  = var.environment


  sg_name      = "${var.project_name}-jenkins-sg"
  vpc_id       = data.aws_vpc.default.id
  common_tags  = var.common_tags
  allowed_ports = var.jenkins_ports

  sg_tags = {
    Purpose = "jenkins-access"
    Managed = "terraform"
  }
}


module "jenkins-master" {
  source                 = "../modules/ec2"
  ami                    = data.aws_ami.ubuntu_surnoi.id
  instance_names         = var.instance_names.jenkins
  instance_type          = var.instance_types.jenkins
  instance_count         = length(var.instance_names.jenkins)
  vpc_security_group_ids = [module.sg_jenkins.security_group_id]
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
  vpc_security_group_ids = [module.sg_backend.security_group_id]
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

