# VPC Variables
variable "region" {
  default       = "us-east-1"
  description   = "AWS Region"
  type          = string
}
variable "env"{
  default = "dev"
  description = "name of the environment"
}
variable "profile" {
  default = "dev"
  description = "please provide profile to take credencials"
}
variable "vpc-cidr" {
  default       = "10.0.0.0/16"
  description   = "VPC CIDR Block"
  type          = string
}