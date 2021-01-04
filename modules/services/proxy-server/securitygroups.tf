resource "aws_security_group" "proxy-instance-sg" {
  vpc_id      = var.VPC_ID
  name        = "proxy-instance-sg"
  description = "security group for proxy instance"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.elb-securitygroup.id]
  }

  tags = {
    Name = "Proxy-ELB"
  }
}

resource "aws_security_group" "elb-securitygroup" {
  vpc_id      = var.VPC_ID
  name        = "elb-${var.ENV}-securitygroup"
  description = "security group for load balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "elb"
    Environment = var.ENV
  }
}
