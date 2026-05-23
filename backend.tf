terraform {
  backend "s3" {
    bucket = "ecr-qlee"
    key    = "state"
    region = "eu-central-1"
  }
}
