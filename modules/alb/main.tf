############ Creation of Application Load Balancer for Open Project  ###############
resource "aws_lb" "demo_alb_uc1" {
  name               = "app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [var.security_groups_id_alb]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "tg_group" {
  name     = "target-tg"
  port     = 80
  protocol = var.tg_grp_protocal
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "web_tg_attachment" {
  target_group_arn = aws_lb_target_group.tg_group.arn
  target_id        = var.target_ids
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.demo_alb_uc1.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_group.arn
  }
}

############ Creation of Application Load Balancer for Data Lake  ###############

resource "aws_lb" "data_lake" {
  name               = "data-lake-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [var.security_groups_id_alb]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "data_lake_tg_group" {
  name     = "data-lake-tg"
  port     = 4000
  protocol = var.tg_grp_protocal
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "data_lake_tg_attachment" {
  target_group_arn = aws_lb_target_group.data_lake_tg_group.arn
  target_id        = var.instance_id2
  port             = 4000
}

resource "aws_lb_listener" "datalake_listener" {
  load_balancer_arn = aws_lb.data_lake.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.data_lake_tg_group.arn
  }
}