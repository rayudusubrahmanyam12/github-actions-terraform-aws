
data "aws_s3_bucket" "acme-s3-access-logging" {
  bucket = var.acme_s3_logging_bucket
}

module "acme_finance_bucket" {
  source = "./modules/acme_bucket"
  bucket_name = "finance-reports"
  cost_centre = "CC001"

  s3_logging_bucket = var.acme_s3_logging_bucket
}

resource "aws_s3_bucket" "bucket-with-encryption-and-logging" {
  bucket = "saanvi-my-passing-bucket"

  logging {
    target_bucket = data.aws_s3_bucket.acme-s3-access-logging.id
    target_prefix = "saanvi-my-passing-bucket/logs/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "bucket-with-encryption" {
  bucket = "saanvi-my-failing-bucket-no-logging"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "bucket-with-logging" {
  bucket = "saanvi-my-failing-bucket-no-encryption"

  logging {
    target_prefix = "saanvi-my-failing-bucket-not-encryption/logs/"
    target_bucket = data.aws_s3_bucket.acme-s3-access-logging.id
  }
}

resource "aws_s3_bucket" "bucket-with-encryption-and-logging-but-public" {
  bucket = "saanvi-my-public-bucket"
  acl = "public-read"

  logging {
    target_bucket = data.aws_s3_bucket.acme-s3-access-logging.id
    target_prefix = "saanvi-my-passing-bucket/logs/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}