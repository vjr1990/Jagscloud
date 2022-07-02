provider "aws" {
    region = var.region
    profile = "dev"
    shared_credentials_file = "~/.aws/credentials"
}
