output "restaurant_ip_address" {
  value = aws_instance.restaurant-service.public_ip
}

#output "rds" {
 # value = aws_db_instance.mysqldb.endpoint
#}

output "restaurant_sgid" { 
  value = aws_security_group.restaurant-sg.id
}

