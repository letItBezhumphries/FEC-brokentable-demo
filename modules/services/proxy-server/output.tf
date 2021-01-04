output "proxy_instance_sgid" { 
  value = aws_security_group.proxy-instance-sg.id
}

output "elb_sgid" {
  value = aws_security_group.elb-securitygroup.id
}

output "ELB" {
  value = aws_elb.brokentable-elb.dns_name
}

