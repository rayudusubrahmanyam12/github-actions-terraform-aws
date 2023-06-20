provider "aws" {
  region = "ap-south-1"
  assume_role {
    role_arn     = "arn:aws:iam::389028963485:role/my-github-actions-role"
    session_name = "example"
  }
}