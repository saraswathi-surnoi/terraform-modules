# ---------------- Jenkins Master Outputs ----------------
output "jenkins_public_ips" {
  description = "Public IP of Jenkins Master"
  value       = module.jenkins-master.instance_public_ips
}

output "jenkins_private_ips" {
  description = "Private IP of Jenkins Master"
  value       = module.jenkins-master.instance_private_ips
}

# ---------------- Backend Servers Outputs ----------------
output "backend_public_ips" {
  description = "Public IPs of Backend Servers"
  value       = module.backend.instance_public_ips
}

output "backend_private_ips" {
  description = "Private IPs of Backend Servers"
  value       = module.backend.instance_private_ips
}
