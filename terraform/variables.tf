variable "acme_s3_logging_bucket" {
  description = "The s3 logging bucket"
  default = "acme-s3-access-bucket"
}

variable "account_id" {
  default = "389028963485"
  
}

variable "assume_role" {
  default = "my-github-actions-role"
}