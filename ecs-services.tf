resource "aws_ecs_service" "czarfoods_ecs_service" {
  name            = "${var.default_tags["Project"]}-ecs-service"
  cluster         = aws_ecs_cluster.czarfoods_ecs_cluster.id
  task_definition = aws_ecs_task_definition.CZ_client.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.czarfoods_tg.arn
    container_name   = "client"
    container_port   = 9090
  }

  network_configuration {
    subnets         = aws_subnet.czarfoods_private_subnet.*.id
    assign_public_ip = false
    security_groups = [aws_security_group.czarfoods_client_service_sg.id]
  }

  tags = {
    Name = "${var.default_tags["Project"]}-ecs-service"
  }
}



##########

resource "aws_ecs_service" "czarfoods_ecs_service_fruits" {
  name            = "${var.default_tags["Project"]}-fruits"
  cluster         = aws_ecs_cluster.czarfoods_ecs_cluster.id
  task_definition = aws_ecs_task_definition.CZ_fruits.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.czarfoods_fruits_tg.arn
    container_name   = "fruits"
    container_port   = 9090
  }

  network_configuration {
    subnets         = aws_subnet.czarfoods_private_subnet.*.id
    assign_public_ip = false
    security_groups = [aws_security_group.czarfoods_fruits_service_sg.id]
  }

  tags = {
    Name = "${var.default_tags["Project"]}-fruits"
  }
}


#####

resource "aws_ecs_service" "czarfoods_ecs_service_vegetables" {
  name            = "${var.default_tags["Project"]}-vegetables"
  cluster         = aws_ecs_cluster.czarfoods_ecs_cluster.id
  task_definition = aws_ecs_task_definition.CZ_vegetables.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.czarfoods_vegetables_tg.arn
    container_name   = "vegetables"
    container_port   = 9090
  }

  network_configuration {
    subnets         = aws_subnet.czarfoods_private_subnet.*.id
    assign_public_ip = false
    security_groups = [aws_security_group.czarfoods_vegetables_service_sg.id]
  }

  tags = {
    Name = "${var.default_tags["Project"]}-vegetables"
  }
}