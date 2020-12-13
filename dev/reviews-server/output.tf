output "reviews_frontend_ip" {
  value = module.reviews-service.reviews_ip_address
}

output "reviews_db_endpoint" {
  value = module.reviews-db.reviews_rds_endpoint
}

output "reviews_securitygroup_id" {
  value = module.reviews-service.reviews_sgid
}

output "host" {
  value = split(":", module.reviews-db.reviews_rds_endpoint)[0]
}

output "port" {
  value = split(":", module.reviews-db.reviews_rds_endpoint)[1]
}
