
# Repo STATE file 
terraform {
  backend "s3" {
    bucket         = "ap-s3-terraform-use"
    region         = "us-east-1"
    dynamodb_table = "ap-dyn-terraform-use"
    encrypt        = true
  }
} 

# Provider & TF Role
provider "aws" {
	region  = "us-east-1"
	version = "~> 4.28"
	assume_role { 
		role_arn = "arn:aws:iam::${var.accountid}:role/ap-role-terraform"
	}
	default_tags {
		tags = local.tags
	}
}
