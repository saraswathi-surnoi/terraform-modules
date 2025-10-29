output "public_ip" {
  description = "Public IPs of EC2 instances"
  value       = module.ec2.instance_public_ips
}

output "private_ip" {
  description = "Private IPs of EC2 instances"
  value       = module.ec2.instance_private_ips
}

output "instance_id" {
  description = "IDs of EC2 instances"
  value       = module.ec2.instance_ids
}

output "instance_names_with_ips" {
  description = "Instance names with their public IPs"
  value = {
    for i, name in var.instance_names : name => module.ec2.instance_public_ips[i]
  }
}
