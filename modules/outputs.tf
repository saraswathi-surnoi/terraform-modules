output "public_ip" {
    value = module.ec2.public_ip
}
output "private" {
    value = module.ec2.private_ip
}
output "id" {
    value = module.ec2.instance_id
}
output "security_group_id" {
  value       = module.security_group.id
  description = "ID of the created security group"
}
