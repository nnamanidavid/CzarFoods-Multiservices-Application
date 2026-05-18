resource "aws_lb" "czarfoods_alb" {
  name               = "${var.default_tags["Project"]}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.czarfoods_lb_sg.id]
  subnets            = aws_subnet.czarfoods_public_subnet.*.id
  ip_address_type    = "ipv4"
  idle_timeout       = 60

  tags = {
    Name = "${var.default_tags["Project"]}-alb"
  }
}

resource "aws_lb_target_group" "czarfoods_tg" {
  name     = "${var.default_tags["Project"]}-tg"
  port     = 9090
  protocol = "HTTP"
  vpc_id   = aws_vpc.czarfoods_vpc.id
  target_type = "ip"
  deregistration_delay = 30

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 60
    timeout             = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.default_tags["Project"]}-tg"
  }
}

resource "aws_lb_listener" "czarfoods_listener" {
  load_balancer_arn = aws_lb.czarfoods_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.czarfoods_tg.arn
  }
}


#####

resource "aws_lb" "cz_fruits_alb" {
  name              = "${var.default_tags["Project"]}-fruits"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.czarfoods_fruits_lb_sg.id]
  subnets            = aws_subnet.czarfoods_private_subnet.*.id
  idle_timeout       = 60

  tags = {
    Name = "${var.default_tags["Project"]}-fruits-alb"
  }
}

resource "aws_lb_target_group" "czarfoods_fruits_tg" {
  name     = "${var.default_tags["Project"]}-fruits-tg"
  port     = 9090
  protocol = "HTTP"
  vpc_id   = aws_vpc.czarfoods_vpc.id
  target_type = "ip"
  deregistration_delay = 30

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 60
    timeout             = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.default_tags["Project"]}-fruits-tg"
  }
}


resource "aws_lb_listener" "czarfoods_fruits_listener" {
  load_balancer_arn = aws_lb.cz_fruits_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.czarfoods_fruits_tg.arn
  }
}




#####

resource "aws_lb" "cz_vegetables_alb" {
  name              = "${var.default_tags["Project"]}-vegetables"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.czarfoods_vegetables_lb_sg.id]
  subnets            = aws_subnet.czarfoods_private_subnet.*.id
  idle_timeout       = 60

  tags = {
    Name = "${var.default_tags["Project"]}-vegetables-alb"
  }
}

resource "aws_lb_target_group" "czarfoods_vegetables_tg" {
  name     = "${var.default_tags["Project"]}-vegetables-tg"
  port     = 9090
  protocol = "HTTP"
  vpc_id   = aws_vpc.czarfoods_vpc.id
  target_type = "ip"
  deregistration_delay = 30

  health_check {
    enabled             = true
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 60
    timeout             = 30
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = {
    Name = "${var.default_tags["Project"]}-vegetables-tg"
  }
}


resource "aws_lb_listener" "czarfoods_vegetables_listener" {
  load_balancer_arn = aws_lb.cz_vegetables_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.czarfoods_vegetables_tg.arn
  }
}