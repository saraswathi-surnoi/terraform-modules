resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.key.public_key_openssh
}

output "private_key_pem" {
  description = "Private key content (save this locally)"
  value       = tls_private_key.key.private_key_pem
  sensitive   = true
}
