resource "aws_elb" "brokentable-elb" {
  name            = "brokentable-${var.ENV}-elb"
  subnets         = [element(var.PUBLIC_SUBNETS, 0), element(var.PUBLIC_SUBNETS, 1), element(var.PUBLIC_SUBNETS, 2)]
  security_groups = [aws_security_group.elb-securitygroup.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  
  tags = {
    Name = "brokentable-${var.ENV}-elb"
    Terraform = "true"
    Environment = var.ENV
  }
}
