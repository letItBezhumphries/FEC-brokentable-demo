resource "aws_db_subnet_group" "mysqldb-subnet" {
  name        = "mysqldb-subnet"
  description = "RDS subnet group"
  subnet_ids  = [element(var.PRIVATE_SUBNETS, 0), element(var.PRIVATE_SUBNETS, 1)]
}

resource "aws_db_parameter_group" "mysqldb-parameters" {
  name        = "mysqldb-parameters"
  family      = "mysql5.7"
  description = "MySQL DB parameter group"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "mysqldb" {
  allocated_storage       = 100 # 100 GB of storage
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro" # use micro if you want to use the free tier
  identifier              = "mysqldb"
  name                    = "mysqldb"
  username                = var.MYSQL_USERNAME  # username
  password                = var.MYSQL_PASSWORD # password
  db_subnet_group_name    = aws_db_subnet_group.mysqldb-subnet.name
  parameter_group_name    = aws_db_parameter_group.mysqldb-parameters.name
  multi_az                = "false" # set to true to have high availability: 2 instances synchronized with each other
  vpc_security_group_ids  = [aws_security_group.allow-mysqldb.id]
  storage_type            = "gp2"
  backup_retention_period = 30                                   
  availability_zone       = var.RDS_AZ
  skip_final_snapshot     = true                                        # skip final snapshot when doing terraform destroy
  tags = {
    Name = "mysqldb-instance"
  }
}
