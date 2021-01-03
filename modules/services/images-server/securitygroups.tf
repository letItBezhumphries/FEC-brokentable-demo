/* Securitygroup	
Port 22 -- Open to ssh without limitations
     
egress  - Open to all
*/

resource "aws_security_group" "images-sg" {
  vpc_id      = var.VPC_ID
  name        = "allow-ssh-${var.ENV}"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  #ingress {
  #  from_port = 27017
  #  to_port   = 27017
  #  protocol  = "tcp"
  #  cidr_blocks = [
  #    "0.0.0.0/0"
  #  ]
  #}

 # ingress {
 #   from_port = 27019
 #   to_port   = 27019
 #   protocol  = "tcp"
 #   cidr_blocks = [
 #     "0.0.0.0/0"
 #   ]
 # }

  tags = {
    Name         = "allow-ssh"
    Environmnent = var.ENV
  }
}


