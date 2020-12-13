
resource "aws_security_group" "allow-mysqldb" {
  vpc_id      = var.VPC_ID
  name        = "allow-mysqldb-${var.SERVICE}"
  description = "allow-mysqldb"
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.REVIEWS_SG_ID] # allowing access from the reviews-server instance
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }
  
  tags = {
    Name = "allow-mysqldb-${var.SERVICE}"
    Environment = var.ENV
  }
}
