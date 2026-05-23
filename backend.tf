terraform {
  backend "s3" {
    bucket = "gh-test-bucket-qlee"
    key    = "state"
    region = "eu-central-1"
  }
}
