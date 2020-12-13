resource "aws_instance" "reviews-service" {
  ami           = var.AMI_ID
  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
  subnet_id = element(var.PUBLIC_SUBNETS, 0)

  # the security group
  vpc_security_group_ids = [aws_security_group.reviews-sg.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  # User-data
  user_data              = data.template_cloudinit_config.cloudinit-install-script.rendered
  
  tags = {
    Name         = "reviews-service-${var.ENV}"
    Environmnent = var.ENV
  }
}
