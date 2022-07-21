#resource "aws_sqs_queue" "admin" {
#  name = "${local.project_name}AdminQueue"
#  message_retention_seconds = 86400
#  receive_wait_time_seconds = 20
#  visibility_timeout_seconds = 900
#  kms_master_key_id = aws_kms_key.queue.id
#  redrive_policy = jsonencode({
#    deadLetterTargetArn = aws_sqs_queue.dlq.arn,
#    maxReceiveCount = 3
#  })
#}
#
#resource "aws_sqs_queue" "dlq" {
#  name                              = "${local.project_name}AdminDeadLetterQueue"
#  message_retention_seconds         = 86400
#  kms_master_key_id                 = aws_kms_key.queue.id
#}
#
#resource "aws_kms_key" "queue" {
#  enable_key_rotation     = "true"
#  deletion_window_in_days = var.kms_deletion_days
#}
#
#resource "aws_kms_alias" "queue" {
#  name          = "alias/${lower(local.project_name)}-admin-queue-encryption-key"
#  target_key_id = aws_kms_key.queue.key_id
#}
##
##resource "aws_sqs_queue_policy" "queue" {
##  queue_url = aws_sqs_queue.queue.id
##  policy    = data.aws_iam_policy_document.queue.json
##}
##
##resource "aws_sqs_queue_policy" "dlq" {
##  queue_url = aws_sqs_queue.dlq.id
##  policy    = data.aws_iam_policy_document.queue.json
##}
##
##data "aws_iam_policy_document" "queue" {
##  statement {
##    resources = [
##      aws_sqs_queue.queue.arn,
##      aws_sqs_queue.dlq.arn,
##    ]
##    actions = [
##      "sqs:ChangeMessageVisibility",
##      "sqs:DeleteMessage",
##      "sqs:GetQueueAttributes",
##      "sqs:GetQueueUrl",
##      "sqs:ListQueueTags",
##      "sqs:ReceiveMessage",
##      "sqs:SendMessage",
##    ]
##  }
##}
