terraform {
  backend "s3" {
    bucket         = "ecommerce-tf-state-saji-1"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}