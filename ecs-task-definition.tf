resource "aws_ecs_task_definition" "CZ_client" {
  family                   = "${var.default_tags["Project"]}-client"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = "client"
      image     = "nicholasjackson/fake-service:v0.26.2"
      cpu       = 0
      essential = true

      portMappings = [
        {
          containerPort = 9090
          hostPort      = 9090
          protocol      = "tcp"
        }
      ]

      Environment = [
        {
          name  = "NAME"
          value = "client"
        },
        {
          name  = "MESSAGE"
          value = "hello from czar client"
        },
        { 
          name  = "UPSTREAM_URIS"
          value = "http://${aws_lb.cz_fruits_alb.dns_name}"
        }
        
      ]
    }

  ])


  tags = {
    Name = "${var.default_tags["Project"]}-task-def"
  }
}




resource "aws_ecs_task_definition" "CZ_fruits" {
  family                   = "${var.default_tags["Project"]}-fruits"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = "fruits"
      image     = "nicholasjackson/fake-service:v0.26.2"
      cpu       = 0
      essential = true

      portMappings = [
        {
          containerPort = 9090
          hostPort      = 9090
          protocol      = "tcp"
        }
      ]

      Environment = [
        {
          name  = "NAME"
          value = "fruits"
        },
        {
          name  = "MESSAGE"
          value = "hello from czar fruits clients"
        }
      ]
    }
  ])

  tags = {
    Name = "${var.default_tags["Project"]}-fruits-task-def"
  }
}



resource "aws_ecs_task_definition" "CZ_vegetables" {
  family                   = "${var.default_tags["Project"]}-vegetables"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512

  container_definitions = jsonencode([
    {
      name      = "vegetables"
      image     = "nicholasjackson/fake-service:v0.26.2"
      cpu       = 0
      essential = true

      portMappings = [
        {
          containerPort = 9090
          hostPort      = 9090
          protocol      = "tcp"
        }
      ]

      Environment = [
        {
          name  = "NAME"
          value = "vegetables"
        },
        {
          name  = "MESSAGE"
          value = "hello from czar vegetables clients"
        }
      ]
    }
  ])

  tags = {
    Name = "${var.default_tags["Project"]}-vegetables-task-def"
  }
}