output "reviews_ip_address" {
  value = aws_instance.reviews-service.public_ip
}

output "reviews_sgid" { 
  value = aws_security_group.reviews-sg.id
}

