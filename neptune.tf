resource "aws_neptune_cluster" "orbital" {
  cluster_identifier     = lower(local.project_name)
  engine                 = "neptune"
  skip_final_snapshot    = true
  apply_immediately      = true
  vpc_security_group_ids = var.vpc_security_group_ids
  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
}

resource "aws_neptune_cluster_instance" "orbital" {
  count              = 2
  cluster_identifier = aws_neptune_cluster.orbital.id
  engine             = "neptune"
  instance_class     = "db.t3.medium"
  apply_immediately  = true
  identifier_prefix  = "${aws_neptune_cluster.orbital.cluster_identifier}-"
  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }
}

resource "aws_neptune_cluster_endpoint" "orbital" {
  cluster_identifier          = aws_neptune_cluster.orbital.id
  cluster_endpoint_identifier = aws_neptune_cluster.orbital.cluster_identifier
  endpoint_type               = "ANY"
  depends_on                  = [aws_neptune_cluster_instance.orbital]
}
