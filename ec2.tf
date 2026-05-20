resource "aws_instance" "czarfoods_database" {
  ami           = data.aws_ssm_parameter.ubuntu_ami_id.value
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.database_sg.id]
  subnet_id = aws_subnet.czarfoods_private_subnet[0].id
  private_ip    = var.DB_private_ip
  key_name      = var.instance_key_name

  tags = {
    Name = "${var.default_tags["Project"]}-database"
  }

  user_data_base64 = base64encode(templatefile("${path.module}/scripts/database.sh",{
        DATABASE_SERVICE_NAME = var.database_service_name
        DATABASE_MESSAGE = var.database_message 
    }))

}