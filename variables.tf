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

variable "ssh_key" {
  description = "SSH public key"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDi4cy26fcTsBPregOuIq1MxR3yeTocC2ZEp04U5BGYd kulik@QLEE-PC"
}