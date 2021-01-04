resource "aws_launch_configuration" "proxy-launchconfig" {
  name_prefix     = "proxy-launchconfig"
  image_id        = var.AMI_ID
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.proxy-instance-sg.id]

  user_data       = data.template_cloudinit_config.cloudinit-install-script.rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "brokentable-autoscaling" {
  name                      = "brokentable-autoscaling"
  vpc_zone_identifier       = [element(var.PUBLIC_SUBNETS, 0), element(var.PUBLIC_SUBNETS, 1), element(var.PUBLIC_SUBNETS, 2)]
  launch_configuration      = aws_launch_configuration.proxy-launchconfig.name
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.brokentable-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 proxy instance"
    propagate_at_launch = true
  }
}

#resource "aws_instance" "proxy-service" {
#  ami           = var.AMI_ID
#  instance_type = var.INSTANCE_TYPE

  # the VPC subnet
  #subnet_id = element(var.PUBLIC_SUBNETS, 0)

  # the security group
  #vpc_security_group_ids = [aws_security_group.proxy-sg.id]

  # the public SSH key
  #key_name = aws_key_pair.mykeypair.key_name

  #associate_public_ip_address = true

  # User-data
  #user_data = data.template_cloudinit_config.cloudinit-install-script.rendered
  
  #tags = {
  #  Name         = "proxy-service-${var.ENV}"
  #  Environmnent = var.ENV
  #}
#}
