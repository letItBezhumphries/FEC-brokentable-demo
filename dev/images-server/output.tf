output "images_frontend_ip" {
  value = module.images-service.ip_address
}

output "images_securitygroup_id" {
  value = module.images-service.images_sgid
}



