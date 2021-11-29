resource "aws_iam_role" "lambda" {
  name = "${local.project_name}LambdaRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda" {
  name   = "${aws_iam_role.lambda.name}Policy"
  role   = aws_iam_role.lambda.id
  policy = data.aws_iam_policy_document.lambda.json
}

data "aws_iam_policy_document" "lambda" {
  source_policy_documents = [
    data.aws_iam_policy_document.manage_eni.json,
    data.aws_iam_policy_document.create_logs.json,
  ]
}


resource "aws_iam_role" "appsync" {
  name = "${local.project_name}AppsyncRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "appsync" {
  name   = "${aws_iam_role.appsync.name}Policy"
  role   = aws_iam_role.appsync.id
  policy = data.aws_iam_policy_document.appsync.json
}

data "aws_iam_policy_document" "appsync" {
  source_policy_documents = [
    data.aws_iam_policy_document.invoke_lambda.json,
    data.aws_iam_policy_document.create_logs.json,
  ]
}
