provider "aws" {
  shared_credentials_file = "/root/.aws/credentials"
  profile                 = "dev"
  region                  = "us-east-1"
}
