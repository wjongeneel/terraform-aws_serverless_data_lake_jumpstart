terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

  backend "s3" {
    bucket  = "tf-state-0001"
    key     = "state/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
}
}
