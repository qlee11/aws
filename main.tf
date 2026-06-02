provider "aws" {
  region = var.region
}


module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name                 = "tavernquest"
  repository_type                 = "private"
  create_repository               = true
  repository_force_delete         = true
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

resource "aws_ecs_task_definition" "test-tf" {
  family = "service"
  container_definitions = jsonencode([
    {
      name      = "first"
      image     = "982081085352.dkr.ecr.eu-central-1.amazonaws.com/tavernquest:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
  ])
}

resource "aws_ecs_cluster" "test-cluster" {
  name = "tavernquest"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_service" "tavernquest" {
  name            = "tavernquest-service"
  cluster         = aws_ecs_cluster.test-cluster.id
  task_definition = aws_ecs_task_definition.test-tf.arn

}