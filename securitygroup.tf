resource "aws_security_group" "czarfoods_lb_sg" {
  name        = "${var.default_tags["Project"]}-sg"
  description = "Security group for Czarfoods ECS cluster"
  vpc_id      = aws_vpc.czarfoods_vpc.id
}

resource "aws_security_group_rule" "czarclient_abl_allow_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.czarfoods_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow HTTP traffic from anywhere"
}

resource "aws_security_group_rule" "czarclient_abl_allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.czarfoods_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound traffic from anywhere"
}



###security for client service
resource "aws_security_group" "czarfoods_client_service_sg" {
    name        = "${var.default_tags["Project"]}-client-service-sg"
    description = "Security group for Czarfoods ECS service"
    vpc_id      = aws_vpc.czarfoods_vpc.id
}


resource "aws_security_group_rule" "czarclient_service_allow_9090" {
  type              = "ingress"
  from_port         = 9090
  to_port           = 9090
  protocol          = "tcp"
  security_group_id = aws_security_group.czarfoods_client_service_sg.id
  source_security_group_id = aws_security_group.czarfoods_lb_sg.id
  description       = "Allow incoming traffic from client ALB into the service container port 9090"
}

resource "aws_security_group_rule" "czarclient_service_allow_inbound_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  self              = true
  security_group_id = aws_security_group.czarfoods_client_service_sg.id
  description       = "Allow all inbound traffic from within the security group (for service to service communication)"

}


resource "aws_security_group_rule" "czarclient_service_allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.czarfoods_client_service_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound traffic from the service"
}



#####

resource "aws_security_group" "czarfoods_fruits_lb_sg" {
  name        = "${var.default_tags["Project"]}-fruits-sg"
  description = "Security group for Czarfoods ECS cluster"
  vpc_id      = aws_vpc.czarfoods_vpc.id
}

resource "aws_security_group_rule" "czar_fruits_abl_allow_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = aws_security_group.czarfoods_client_service_sg.id
  security_group_id = aws_security_group.czarfoods_fruits_lb_sg.id
  description       = "Allow HTTP traffic from anywhere"
}

resource "aws_security_group_rule" "czar_fruits_abl_allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.czarfoods_fruits_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound traffic anywhere"
}




###security for fruits service
resource "aws_security_group" "czarfoods_fruits_service_sg" {
    name        = "${var.default_tags["Project"]}-fruits-service-sg"
    description = "Security group for Czarfoods ECS fruits service"
    vpc_id      = aws_vpc.czarfoods_vpc.id
}


resource "aws_security_group_rule" "czar_fruits_service_allow_9090" {
  type              = "ingress"
  from_port         = 9090
  to_port           = 9090
  protocol          = "tcp"
  security_group_id = aws_security_group.czarfoods_fruits_service_sg.id
  source_security_group_id = aws_security_group.czarfoods_fruits_lb_sg.id
  description       = "Allow incoming traffic from fruits ALB into the service container port 9090"
}

resource "aws_security_group_rule" "czar_fruits_service_allow_inbound_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  self              = true
  security_group_id = aws_security_group.czarfoods_fruits_service_sg.id
  description       = "Allow all inbound traffic from within the security group (for service to service communication)"

}


resource "aws_security_group_rule" "czar_fruits_service_allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.czarfoods_fruits_service_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound traffic from the service"
}




####
resource "aws_security_group" "czarfoods_vegetables_lb_sg" {
  name        = "${var.default_tags["Project"]}-vegetables-lb-sg"
  description = "Security group for Czarfoods ECS cluster"
  vpc_id      = aws_vpc.czarfoods_vpc.id
}

resource "aws_security_group_rule" "czar_vegetables_lb_allow_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = aws_security_group.czarfoods_client_service_sg.id
  security_group_id = aws_security_group.czarfoods_vegetables_lb_sg.id
  description       = "Allow HTTP traffic from anywhere"
}

resource "aws_security_group_rule" "czar_vegetables_lb_allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.czarfoods_vegetables_lb_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound traffic anywhere"
}


###security for vegetables service
resource "aws_security_group" "czarfoods_vegetables_service_sg" {
    name        = "${var.default_tags["Project"]}-vegetables-service-sg"
    description = "Security group for Czarfoods ECS vegetables service"
    vpc_id      = aws_vpc.czarfoods_vpc.id
}


resource "aws_security_group_rule" "czar_vegetables_service_allow_9090" {
  type              = "ingress"
  from_port         = 9090
  to_port           = 9090
  protocol          = "tcp"
  security_group_id = aws_security_group.czarfoods_vegetables_service_sg.id
  source_security_group_id = aws_security_group.czarfoods_vegetables_lb_sg.id
  description       = "Allow incoming traffic from vegetables ALB into the service container port 9090"
}

resource "aws_security_group_rule" "czar_vegetables_service_allow_inbound_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  self              = true
  security_group_id = aws_security_group.czarfoods_vegetables_service_sg.id
  description       = "Allow all inbound traffic from within the security group (for service to service communication)"

}


resource "aws_security_group_rule" "czar_vegetables_service_allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.czarfoods_vegetables_service_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound traffic from the service"
}


#####
resource "aws_security_group" "database_sg" {
    name        = "${var.default_tags["Project"]}-database-sg"
    description = "Security group for Czarfoods database instance"
    vpc_id      = aws_vpc.czarfoods_vpc.id
}


resource "aws_security_group_rule" "database_allow_vegs_27017" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = aws_security_group.database_sg.id
  source_security_group_id = aws_security_group.czarfoods_vegetables_service_sg.id
  description       = "Allow incoming traffic from vegetables ALB into the service container port 9090"
}

resource "aws_security_group_rule" "database_allow_fruits_27017" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = aws_security_group.database_sg.id
  source_security_group_id = aws_security_group.czarfoods_fruits_service_sg.id
  description       = "Allow incoming traffic from fruits service into the database"
}


resource "aws_security_group_rule" "database_allow_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  security_group_id = aws_security_group.database_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow outbound traffic from the service"
}