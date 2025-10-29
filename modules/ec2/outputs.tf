output "instance_ids" {
  value = aws_instance.ec2[*].id
}

output "instance_public_ips" {
  value = aws_instance.ec2[*].public_ip
}

output "instance_private_ips" {
  value = aws_instance.ec2[*].private_ip
}
