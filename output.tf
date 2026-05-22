output "vpc_id" {
  value = aws_vpc.czarfoods_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.czarfoods_public_subnet.*.id
}

output "client_alb_dns_name" {
  value = aws_lb.czarfoods_alb.dns_name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.czarfoods_ecs_cluster.name
}

output "database_ip" {
  value = aws_instance.czarfoods_database.private_ip
}
