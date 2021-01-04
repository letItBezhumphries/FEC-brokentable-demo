output "proxy_frontend_ip" {
  value = module.proxy-service.ELB
}

output "proxy_securitygroup" {
  value = module.proxy-service.proxy_instance_sgid
}

output "elb_securitygroup" {
  value = module.proxy-service.elb_sgid
}

