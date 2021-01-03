output "ip_address" {
  value = aws_instance.images-service.public_ip
}

output "images_sgid" { 
  value = aws_security_group.images-sg.id
}

