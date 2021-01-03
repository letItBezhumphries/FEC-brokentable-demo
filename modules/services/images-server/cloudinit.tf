data "template_file" "init-script" {
  template = file("${path.module}/launch-scripts/deploy_server.sh")
  vars     = {
    MONGODB_PASSWORD = var.MONGODB_PASSWORD
    MONGODB_USERNAME = var.MONGODB_USERNAME
    ATLAS_HOST       = var.ATLAS_HOST
    PORT             = var.PORT,
    DB_NAME          = var.DB_NAME
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
