resource "aws_security_group" "restaurant-sg" {
  vpc_id      = var.VPC_ID
  name        = "allow-ssh-${var.ENV}"
  description = "security group that allows ssh and all egress traffic"

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

  tags = {
    Name         = "allow-ssh"
    Environmnent = var.ENV
  }
}

#resource "aws_security_group" "allow-mysqldb" {
 # vpc_id      = var.VPC_ID
 # name        = "allow-mysqldb-${var.ENV}"
 # description = "allow-mysqldb"
 # ingress {
 #   from_port       = 3306
 #   to_port         = 3306
  #  protocol        = "tcp"
   # security_groups = [aws_security_group.restaurant-sg.id] # allowing access from our restaurant instance
 # }
  #egress {
   # from_port   = 0
   # to_port     = 0
   # protocol    = "-1"
   # cidr_blocks = ["0.0.0.0/0"]
   # self        = true
 # }
  #tags = {
   # Name = "allow-mysqldb"
   # Environment = var.ENV
 # }
#}
