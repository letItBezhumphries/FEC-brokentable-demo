data "template_file" "init-script" {
  template = file("${path.module}/launch-scripts/setup_dotenv.sh")
  vars     = {
    RDS_PASSWORD = var.MYSQL_PASSWORD
    RDS_HOST     = var.host
    RDS_USERNAME = var.MYSQL_USERNAME
    RDS_PORT     = var.port
  }
}

data "template_cloudinit_config" "cloudinit-install-script" {
  gzip = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.init-script.rendered
  }
}