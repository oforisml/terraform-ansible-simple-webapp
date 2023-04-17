terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  default_tags {
    tags = {
      Project     = "Ansible Terraform Tut"
      owner       = "Samuel Ofori"
      Environment = "ansibleTerraform"
    }
  }
}



