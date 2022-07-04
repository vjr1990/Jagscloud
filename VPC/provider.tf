provider "aws" {
  shared_credentials_file = "/var/lib/jenkins/.aws/credentials"
  profile                 = "dev"
  region                  = "us-east-1"
}
