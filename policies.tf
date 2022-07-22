data "aws_iam_policy_document" "assume_lambda" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "assume_appsync" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["appsync.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "manage_eni" {
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "create_logs" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:GetLogEvents",
      "logs:FilterLogEvents",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${var.region}:${data.aws_caller_identity.this.account_id}:*",
    ]
  }
}

data "aws_iam_policy_document" "invoke_lambda" {
  statement {
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      "arn:aws:lambda:${var.region}:${data.aws_caller_identity.this.account_id}:function:*",
    ]
  }
}

data "aws_iam_policy_document" "query_athena" {
  statement {
    actions = [
      "athena:StartQueryExecution",
      "athena:GetQueryExecution",
      "athena:GetWorkgroup",
      "athena:GetQueryResults",
    ]

    resources = [
      "arn:aws:athena:${var.region}:${data.aws_caller_identity.this.account_id}:workgroup/*",
    ]
  }
  statement {
    actions = [
      "glue:GetTable",
      "glue:GetTables",
      "glue:GetDatabase",
      "glue:GetDataBases",
      "glue:GetPartitions",
    ]
    resources = [
      "arn:aws:glue:${var.region}:${data.aws_caller_identity.this.account_id}:catalog",
      "arn:aws:glue:${var.region}:${data.aws_caller_identity.this.account_id}:database/*",
      "arn:aws:glue:${var.region}:${data.aws_caller_identity.this.account_id}:table/*/*",
    ]
  }
}

data "aws_iam_policy_document" "read_s3" {
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::*",
      "arn:aws:s3:::*/*",
    ]
  }
}

data "aws_iam_policy_document" "write_s3" {
  statement {
    actions = [
      "s3:PutObject",
    ]
    resources = [
      aws_s3_bucket.query_results.arn,
      "${aws_s3_bucket.query_results.arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "access_kms" {
  statement {
    actions = [
      "kms:ListAliases",
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey",
      "kms:GenerateDataKey*",
      "kms:DescribeKey",
    ]
    resources = [
      aws_kms_key.s3.arn,
    ]
  }
}
