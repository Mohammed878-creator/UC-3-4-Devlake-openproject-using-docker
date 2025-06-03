output "dns_alb_open_project" {
  value = aws_lb.demo_alb_uc1.dns_name
}

output "dns_alb_data_lake" {
  value = aws_lb.data_lake.dns_name
}