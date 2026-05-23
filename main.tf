provider "aws" {
  region = var.region
}


module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name = "tavernquest"
  repository_type = "private"
  create_repository = true
  repository_force_delete = true
  repository_image_tag_mutability = "MUTABLE"

  repository_read_write_access_arns = ["arn:aws:iam::982081085352:user/bucket-user"]
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

}