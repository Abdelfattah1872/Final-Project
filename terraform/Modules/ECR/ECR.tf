resource "aws_ecr_repository" "ecr_resource_db" {
  name                 = "db"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    name = "db"
  }
}

resource "aws_ecr_repository" "ecr_resource_app" {
  name                 = "app"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    name = "app"
  }
}
output "ecr_url_APP" {
  description = "ECR URL APP"
  value       = aws_ecr_repository.ecr_resource_app.repository_url
}

output "ecr_url_DB" {
  description = "ECR URL DB"
  value       = aws_ecr_repository.ecr_resource_db.repository_url
}
