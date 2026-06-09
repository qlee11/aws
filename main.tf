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

resource "aws_eks_cluster" "test-cluster" {
    name = "test-custer"
    role_arn = aws_iam_role.cluster.arn

    vpc_config {
      subnet_ids = [ aws_subnet.test-subnet.id, aws_subnet.cluster-subnet.id ]
    }

}

resource "aws_eks_node_group" "test-node-group" {
    cluster_name = aws_eks_cluster.test-cluster.name
    node_group_name = "test-node-group"
    node_role_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    subnet_ids = [ aws_subnet.test-subnet.id ]

    scaling_config {
      desired_size = 1
      max_size     = 2
      min_size     = 1
    }
}

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}