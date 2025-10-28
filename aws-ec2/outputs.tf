output "public_ip" {
  value = [for instance in aws_instance.ec2 : instance.public_ip]
}

output "private_ip" {
  value = [for instance in aws_instance.ec2 : instance.private_ip]
}

output "instance_id" {
  value = [for instance in aws_instance.ec2 : instance.id]
}

output "instance_names_with_ips" {
  value = {
    for i in range(var.instance_count) :
    var.instance_names[i] => aws_instance.ec2[i].public_ip
  }
  description = "Map of instance names to their public IPs"
}