provider "aws" {
   profile    = "dev"
   region     = var.region
   shared_credentials_file = "/root/.aws/credentials"
}
