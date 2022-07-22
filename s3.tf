resource "aws_s3_bucket" "query_results" {
  bucket        = "${lower(local.project_name)}-queries.${var.region}.${data.aws_caller_identity.this.account_id}"
  force_destroy = "true"
}

resource "aws_s3_bucket_acl" "query" {
  bucket = aws_s3_bucket.query_results.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.query_results.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "encrypted" {
  bucket                  = aws_s3_bucket.query_results.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_kms_key" "s3" {
  enable_key_rotation     = "true"
  deletion_window_in_days = var.kms_deletion_days
}

resource "aws_kms_alias" "encrypted" {
  name          = "alias/${lower(local.project_name)}-s3-encryption-key"
  target_key_id = aws_kms_key.s3.key_id
}
