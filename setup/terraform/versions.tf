provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = "1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      # 4.55.0 predates AL2023 ami_type support on aws_eks_node_group
      version = "~> 5.0"
    }
  }
}
