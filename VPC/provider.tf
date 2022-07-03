terraform {
      required_providers {
         aws = {
         source = "hashicorp/aws"
         version = "= 3.74.2"
        }
     }
  }
provider "aws" {
   profile    = "dev"
   region     = var.region
   shared_credentials_file = "/root/.aws/credentials"
}
