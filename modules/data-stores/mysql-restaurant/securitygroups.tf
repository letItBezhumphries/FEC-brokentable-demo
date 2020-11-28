
resource "aws_security_group" "allow-mysqldb" {
  vpc_id      = var.VPC_ID
  name        = "allow-mysqldb-${var.ENV}"
  description = "allow-mysqldb"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.RESTAURANT_SG_ID] # allowing access from the restaurant-service instance
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  
  tags = {
    Name = "allow-mysqldb"
    Environment = var.ENV
  }
}
