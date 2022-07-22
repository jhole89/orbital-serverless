resource "aws_iam_role" "lambda" {
  name               = "${local.project_name}LambdaRole"
  assume_role_policy = data.aws_iam_policy_document.assume_lambda.json
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
    data.aws_iam_policy_document.query_athena.json,
    data.aws_iam_policy_document.read_s3.json,
    data.aws_iam_policy_document.write_s3.json,
    data.aws_iam_policy_document.access_kms.json,
  ]
}

resource "aws_iam_role" "appsync" {
  name               = "${local.project_name}AppsyncRole"
  assume_role_policy = data.aws_iam_policy_document.assume_appsync.json
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
