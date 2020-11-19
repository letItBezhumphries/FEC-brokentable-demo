output "restaurant_public_ip" {
  value = module.restaurant-service.restaurant_ip_address
}

output "restaurant_rds_endpoint" {
  value = module.restaurant-db.restaurant_rds_endpoint
}

output "restaurant_securitygroup_id" {
  value = module.restaurant-service.restaurant_sgid
}

output "host" {
  value = split(":", module.restaurant-db.restaurant_rds_endpoint)[0]
}

output "port" {
  value = split(":", module.restaurant-db.restaurant_rds_endpoint)[1]
}
