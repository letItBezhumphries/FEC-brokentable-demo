output "restaurant_rds_endpoint" {
  value = aws_db_instance.mysqldb.endpoint
}

output "restaurant_rds_sgid" {
  value = aws_security_group.allow-mysqldb.id
}

