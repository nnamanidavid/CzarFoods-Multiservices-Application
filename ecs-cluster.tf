resource "aws_ecs_cluster" "czarfoods_ecs_cluster" {
  name = "${var.default_tags["Project"]}-ecs-cluster"

  tags = {
    Name = "${var.default_tags["Project"]}-ecs-cluster"
  }
}

