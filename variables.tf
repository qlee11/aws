variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "ami" {
  description = "AMI number"
  type        = string
  default     = "ami-051eaec1417c5d4ae"
}

variable "machine_type" {
  description = "Instance type"
  type        = string
  default     = "t3.micro"
}