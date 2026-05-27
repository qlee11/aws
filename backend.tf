terraform {
  backend "s3" {
    bucket = "gh-test-bucket-qlee"
    key    = "state-new"
    region = "eu-central-1"
  }
}
