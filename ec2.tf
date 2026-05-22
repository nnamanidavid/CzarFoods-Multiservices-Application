resource "aws_instance" "czarfoods_database" {
  ami                    = data.aws_ssm_parameter.ubuntu_ami_id.value
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  subnet_id              = aws_subnet.czarfoods_private_subnet[0].id
  private_ip             = var.DB_private_ip
  key_name               = var.instance_key_name
  iam_instance_profile   = aws_iam_instance_profile.database_instance_profile.name

  tags = {
    Name = "${var.default_tags["Project"]}-database"
  }

  user_data_base64 = base64encode(templatefile("${path.module}/scripts/database.sh", {
    DATABASE_SERVICE_NAME = var.database_service_name
    DATABASE_MESSAGE      = var.database_message
  }))

}


resource "aws_iam_role" "database_ssm_role" {
  name = "database-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "database_ssm_policy" {
  role       = aws_iam_role.database_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "database_instance_profile" {
  name = "database-instance-profile"
  role = aws_iam_role.database_ssm_role.name
}


resource "aws_instance" "czar_bastion" {
  ami                    = data.aws_ssm_parameter.ubuntu_ami_id.value
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  subnet_id              = aws_subnet.czarfoods_public_subnet[1].id
  key_name               = var.instance_key_name

  tags = {
    Name = "${var.default_tags["Project"]}-bastion"
  }

}