resource "mongodbatlas_project_ip_access_list" "atlas-access" {
  project_id = var.project_id
  ip_address = aws_instance.images-service.public_ip
  comment    = "development atlas db access"
}
